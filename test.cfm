<cfscript>
    origin = "34.0522342,-118.2436849"
    radius = 50;
    locations = []  
    locationsCopy = duplicate(locations);
    driving_miles = [];
    if (arrayLen(locations) <= 25) {
        limit = arrayLen(locations)
        locations = locations.slice(1, limit)
        batch = locations.slice(1, limit)

        destinations = []
        
        for (i=1; i <= arrayLen(batch); i++) {
            place = batch[i].lat & "%2C" & batch[i].lng;
            destinations.append(place);  
        }
        

        destinationsList = destinations.toList("%7C");
        writeoutput(destinationsList)
        obj = createObject("component","api.driving_distance"); 
        
        response = invoke(obj,"getDrivingDistance",{origin="#origin#", destinations="#destinationsList#"});
        
        writedump(response);

        for (i=1; i<=arrayLen(response.rows[1].elements); i++) {
            miles = response.rows[1].elements[i].distance.value;
            writeoutput(miles);
            ArrayAppend(driving_miles,miles, true);
        }
    }  
    else {
        limit = 25
        numProcessed = 0
        batchRuns = Ceiling(arrayLen(locations) / limit)
        writeDump(batchRuns)
        batch = locations.slice(1, limit)
        numProcessed++;
        writeDump(batch)
        locations = locations.slice(limit + 1)
        
        destinations = []
        
        for (i=1; i <= arrayLen(batch); i++) {
            place = batch[i].lat & "%2C" & batch[i].lng;
            destinations.append(place);  
        }
        

        destinationsList = destinations.toList("%7C");
        writeoutput(destinationsList)
        obj = createObject("component","api.driving_distance"); 
        
        response = invoke(obj,"getDrivingDistance",{origin="#origin#", destinations="#destinationsList#"});
        
        writedump(response);

        for (i=1; i<=arrayLen(response.rows[1].elements); i++) {
            miles = response.rows[1].elements[i].distance.value;
            writeoutput(miles);
            ArrayAppend(driving_miles,miles, true);
        }

        while (numProcessed <= batchRuns) {
            if (arrayLen(locations) <= 25) {
                break;
            }
            numProcessed++;
            writeoutput(numProcessed)
            limit = 25
            batch = locations.slice(1, limit)
            writeDump(batch)
            locations = locations.slice(limit + 1)

            destinations = []
        
            for (i=1; i <= arrayLen(batch); i++) {
                place = batch[i].lat & "%2C" & batch[i].lng;
                destinations.append(place);  
            }
        

            destinationsList = destinations.toList("%7C");
            writeoutput(destinationsList)
            obj = createObject("component","api.driving_distance"); 
            
            response = invoke(obj,"getDrivingDistance",{origin="#origin#", destinations="#destinationsList#"});
            
            writedump(response);

            for (i=1; i<=arrayLen(response.rows[1].elements); i++) {
                miles = response.rows[1].elements[i].distance.value;
                writeoutput(miles);
                ArrayAppend(driving_miles,miles, true);
            }
        
        }

                limit = arrayLen(locations)
                batch = locations.slice(1, limit)
                writeDump(batch)

                destinations = []
        
                for (i=1; i <= arrayLen(batch); i++) {
                    place = batch[i].lat & "%2C" & batch[i].lng;
                    destinations.append(place);  
                }
                

                destinationsList = destinations.toList("%7C");
                writeoutput(destinationsList)
                obj = createObject("component","api.driving_distance"); 
                
                response = invoke(obj,"getDrivingDistance",{origin="#origin#", destinations="#destinationsList#"});
                
                writedump(response);

                

                for (i=1; i<=arrayLen(response.rows[1].elements); i++) {
                    if (response.rows[1].elements[i].status == "OK") {
                        miles = response.rows[1].elements[i].distance.value;
                    } else {
                        miles = "";
                    }
                    writeoutput(miles);
                    ArrayAppend(driving_miles,miles, true);
                }

                for (i=1; i <= arrayLen(driving_miles); i++) {
                    miles = driving_miles[i];
                    insertMiles = locationsCopy[i].insert("driving_miles", miles, true);  
                }
                
                writedump(locationsCopy);

                final_result = [];

                newRadius = radius * 1609.34;

                for (i=1; i <= arrayLen(locationsCopy); i++) {
                    if (locationsCopy[i].driving_miles <= newRadius) {
                        ArrayAppend(final_result,locationsCopy[i], true);
                    }
                }

                writedump(final_result);
        
    } 

    for (i=1; i <= arrayLen(driving_miles); i++) {
        miles = driving_miles[i];
        insertMiles = locationsCopy[i].insert("driving_miles", miles, true);  
    }
    
    writedump(locationsCopy);

    
</cfscript>