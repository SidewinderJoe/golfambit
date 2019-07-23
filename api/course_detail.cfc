<cfcomponent> 

    <cffunction name="getCourseInfo" access="public" hint="Gets courses within set radius" returnformat="JSON">
        <cfargument name="criteria" type="string" required="true">
        <cfargument name="drive_miles" type="string" required="true">

        <cfscript>
            var courseArray=listToArray(criteria,",",true,true);
            var lat_request = courseArray[1];
            var lng_request = courseArray[2];
            var miles = courseArray[3];

            if (miles > 50) {
                var response = "Please enter a mile radius less than 50 miles";
                return response;
            }
        </cfscript>
        
        <cfquery name="course_response" datasource="courses">
            SELECT course_name, zip, lat, lng, closed, driving_miles, ( 3959 * acos( cos( RADIANS(#lat_request#) ) * cos( radians( lat ) ) 
            * cos( radians( lng ) - RADIANS(#lng_request#) ) 
            + sin( RADIANS(#lat_request#) ) * sin(radians(lat)) ) ) AS distance 
            FROM courses
            WHERE closed = '0'
            HAVING DISTANCE < #miles#
            ORDER BY DISTANCE
        </cfquery>

        <cfscript>
            var locations = [];
            for (var row in course_response) {
                arrayAppend(locations, row);
            }
            
            if (drive_miles == false) {
                return locations;
            }

            var origin = lat_request & "," & lng_request
            var radius = miles / 0.000621
            var locationsCopy = duplicate(locations);
            var driving_miles = []
            if (arrayLen(locations) <= 25) {
                var limit = arrayLen(locations)
                var locations = locations.slice(1, limit)
                var batch = locations.slice(1, limit)
        
                var destinations = []
                
                for (var i=1; i <= arrayLen(batch); i++) {
                    var place = batch[i].lat & "%2C" & batch[i].lng;
                    destinations.append(place);  
                }
                
        
                var destinationsList = destinations.toList("%7C");
                var obj = createObject("component","driving_distance"); 
                
                var response = invoke(obj,"getDrivingDistance",{origin="#origin#", destinations="#destinationsList#"});
            
        
                for (i=1; i<=arrayLen(response.rows[1].elements); i++) {
                    if (response.rows[1].elements[i].status == "OK") {
                        miles = response.rows[1].elements[i].distance.value;
                    } else {
                        miles = "";
                    }
                    ArrayAppend(driving_miles,miles, true);
                }

                for (i=1; i <= arrayLen(driving_miles); i++) {
                    miles = driving_miles[i];
                    var insertMiles = locationsCopy[i].insert("driving_miles", miles, true);  
                }
    
                var final_result = [];
            
                for (i=1; i <= arrayLen(locationsCopy); i++) {
                    if (locationsCopy[i].driving_miles <= radius) {
                        ArrayAppend(final_result,locationsCopy[i], true);
                    }
                }
    
                return final_result;
            }  
            else {
                limit = 25
                var numProcessed = 0
                var batchRuns = Ceiling(arrayLen(locations) / limit)
                batch = locations.slice(1, limit)
                numProcessed++;
                locations = locations.slice(limit + 1)
                
                destinations = []
                
                for (i=1; i <= arrayLen(batch); i++) {
                    place = batch[i].lat & "%2C" & batch[i].lng;
                    destinations.append(place);  
                }
                
                destinationsList = destinations.toList("%7C");
                obj = createObject("component","driving_distance"); 
                
                response = invoke(obj,"getDrivingDistance",{origin="#origin#", destinations="#destinationsList#"});
                
                for (i=1; i<=arrayLen(response.rows[1].elements); i++) {
                    if (response.rows[1].elements[i].status == "OK") {
                        miles = response.rows[1].elements[i].distance.value;
                    } else {
                        miles = "";
                    }
                    ArrayAppend(driving_miles,miles, true);
                }

                while (numProcessed <= batchRuns) {
                    if (arrayLen(locations) <= 25) {
                        break;
                    }
                    numProcessed++;
                    limit = 25
                    batch = locations.slice(1, limit)
                    locations = locations.slice(limit + 1)
        
                    destinations = []
                
                    for (i=1; i <= arrayLen(batch); i++) {
                        place = batch[i].lat & "%2C" & batch[i].lng;
                        destinations.append(place);  
                    }
                
                    destinationsList = destinations.toList("%7C");
                    obj = createObject("component","driving_distance"); 
                    
                    response = invoke(obj,"getDrivingDistance",{origin="#origin#", destinations="#destinationsList#"});
        
                    for (i=1; i<=arrayLen(response.rows[1].elements); i++) {
                        miles = response.rows[1].elements[i].distance.value;
                        ArrayAppend(driving_miles,miles, true);
                    }
                }

                limit = arrayLen(locations)
                batch = locations.slice(1, limit)

                destinations = []
        
                for (i=1; i <= arrayLen(batch); i++) {
                    place = batch[i].lat & "%2C" & batch[i].lng;
                    destinations.append(place);  
                }
                

                destinationsList = destinations.toList("%7C");
                obj = createObject("component","driving_distance"); 
                
                response = invoke(obj,"getDrivingDistance",{origin="#origin#", destinations="#destinationsList#"});

                for (i=1; i<=arrayLen(response.rows[1].elements); i++) {
                    if (response.rows[1].elements[i].status == "OK") {
                        miles = response.rows[1].elements[i].distance.value;
                    } else {
                        miles = "";
                    }
                    ArrayAppend(driving_miles,miles, true);
                }

                for (i=1; i <= arrayLen(driving_miles); i++) {
                    miles = driving_miles[i];
                    var insertMiles = locationsCopy[i].insert("driving_miles", miles, true);  
                }

                var final_result = [];

                for (i=1; i <= arrayLen(locationsCopy); i++) {
                    if (locationsCopy[i].driving_miles <= radius) {
                        ArrayAppend(final_result,locationsCopy[i], true);
                    }
                }

                return final_result;
            } 
        </cfscript>
    </cffunction>

    <cffunction name="getCourseDetails" access="public" hint="Get google place id and course details" returnFormat="JSON">
        <cfset var apikey = "">
        <cfargument name="namezip" type="string" required="true">

        <cfset var PlaceIDRequest = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input='#namezip#'&inputtype=textquery&fields=place_id&key=#apikey#">
	
        <cfhttp url="#PlaceIDRequest#"></cfhttp>
        
        <cfset var response = DeserializeJSON(cfhttp.FileContent)>

        <cfset var PlaceDetailsRequest = "https://maps.googleapis.com/maps/api/place/details/json?placeid=#response.candidates[1].place_id#&fields=name,formatted_address,formatted_phone_number,opening_hours,website,price_level,rating,url,permanently_closed,photos&key=AIzaSyBcKg2Wh15cYQOPrbA0eFfJB997iR-9gm4">

        <cfhttp url="#PlaceDetailsRequest#"></cfhttp>

        <cfset var response = DeserializeJSON(cfhttp.FileContent)>

        <cfreturn response>
    </cffunction>

</cfcomponent>
