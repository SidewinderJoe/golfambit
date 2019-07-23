<cfcomponent> 

    <cffunction name="getDrivingDistance" access="public" hint="Get google driving distance" returnFormat="JSON">
        <cfset var apikey = "AIzaSyBcKg2Wh15cYQOPrbA0eFfJB997iR-9gm4">
        <cfargument name="origin" type="string" required="true">
        <cfargument name="destinations" type="string" required="true">

        <cfset var apikey = "AIzaSyBcKg2Wh15cYQOPrbA0eFfJB997iR-9gm4">

        <cfset var PlaceIDRequest = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#origin#&destinations=#destinations#&key=#apikey#">

        <cfhttp url="#PlaceIDRequest#"></cfhttp>

        <cfset var response = DeserializeJSON(cfhttp.FileContent)>

        <cfreturn response>
    </cffunction>

</cfcomponent>