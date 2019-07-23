<cfcomponent>

    <cffunction name="getCurrentWeather" access="remote" hint="Get course weather by zip" returnformat="JSON">
        <cfset var apikey = "bc5ed1cf0163b770eaf85fb7de0a6943">
        <cfargument name="lat" type="string" required="true">
        <cfargument name="lng" type="string" required="true">
        <cfset var WeatherRequest = "https://api.darksky.net/forecast/#apikey#/#lat#,#lng#?exclude=daily,minutely,alerts,flags,hourly">

        <cfhttp url="#WeatherRequest#"></cfhttp>

        <cfset var response = DeserializeJSON(cfhttp.FileContent)>

        <cfreturn response>
    </cffunction>

</cfcomponent>