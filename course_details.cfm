<cfset course = url.course>
<cfset apiKey = "AIzaSyBcKg2Wh15cYQOPrbA0eFfJB997iR-9gm4">
<!--- <cfdump var = #URLEncodedFormat(course)#> --->
<cfobject component="api.course_detail" name="get_details">
<cfobject component="api.weather" name="get_weather">
<!--- <cfdump var = #get_details#> --->
<cfinvoke component="#get_details#" method="getCourseDetails" namezip="#course#" returnvariable="course_details">
<cfinvoke component="#get_weather#" method="getCurrentWeather" lat="#lat#" lng="#lng#" returnvariable="course_weather">
    
<!--- <cfdump var = #course_details.result.photos#> --->

<!--- <cfdump var = "#course_weather#"> --->

<cfinclude template="header.cfm">
<div id="back_button">
   <a href="/golf_course_locator/index.cfm" class="btn btn-primary"><i class="fas fa-arrow-left"></i> Back to Results</i></a>
</div>

<cfif course_details.result.keyExists("permanently_closed")>
    <p>Sorry, <cfoutput>#course_details.result.name#</cfoutput> is permanently closed.</p>
<cfelse>
    <cfoutput>
        <div id="course_info">
            <h3>#course_details.result.name#</h3>
            <p>#course_details.result.formatted_address#</p>
            <p><a href="tel:#course_details.result.formatted_phone_number#">#course_details.result.formatted_phone_number#</a></p>
            <p><a href="#course_details.result.url#"target="_blank">Directions</a></p>
            <p><a href="#course_details.result.website#"target="_blank">Course Website</a></p>
            <p>Rating: #course_details.result.rating#</p>
        </div>
    </cfoutput>

    <!-- Card -->
<div class="card weather-card col-sm-6" id="weather_card">
    <!-- Card content -->
    <div class="card-body pb-3">
  
      <!-- Title -->
      <h4 class="card-title font-weight-bold">Current Weather</h4>
      <!-- Text -->
      <p class="card-text"><cfoutput>#course_weather.currently.summary#</cfoutput></p>
      <cfscript>
        switch (course_weather.currently.icon) {
			case 'clear-day':
				writeOutput('<i class="fas fa-sun fa-5x"></i>');
				break;
        	case 'clear-night':
				writeOutput('<i class="far fa-moon fa-5x"></i>');
				break;
			case 'rain':
				writeOutput('<i class="fas fa-cloud-rain fa-5x"></i>');
				break;
			case 'snow':
				writeOutput('<i class="fas fa-snowflake fa-5x"></i>');
				break;
			case 'sleet':
				writeOutput('<i class="fas fa-cloud-showers-heavy fa-5x"></i>');
				break;
			case 'wind':
				writeOutput('<i class="fas fa-wind fa-5x"></i>');
				break;
			case 'fog':
				writeOutput('<i class="fas fa-smog fa-5x"></i>');
				break;
			case 'cloudy':
				writeOutput('<i class="fas fa-cloud fa-5x"></i>');
				break;
			case 'partly-cloudy-day':
				writeOutput('<i class="fas fa-cloud-sun fa-5x"></i>');
				break;
			case 'partly-cloudy-night':
				writeOutput('<i class="fas fa-cloud-moon fa-5x"></i>');
				break;
        }
      </cfscript>
      <div>
        <cfscript>course_temp = Ceiling(course_weather.currently.temperature)</cfscript>
        <p class="display-1 degree"><cfoutput>#course_temp#</cfoutput>&#8457;</p>
        <i class="fas fa-sun-o fa-5x pt-3 amber-text"></i>
      </div>
      <div class="d-flex justify-content-between mb-4">
        <p><i class="fas fa-tint fa-lg text-info pr-2"></i><cfoutput>#course_weather.currently.precipProbability * 100#%</cfoutput> Precipitation</p>
        <p><img src="/golf_course_locator/assets/images/north_arrow.svg" style="height:1rem; margin-bottom: 6px; transform: rotate(<cfoutput>#course_weather.currently.windBearing#</cfoutput>deg);"> <cfoutput>#course_weather.currently.windSpeed#</cfoutput> mph Winds</p>
      </div>
      <cfif course_weather.currently.nearestStormDistance GT 0>
        <div>
          <p><i class="fas fa-cloud-showers-heavy"></i> Nearest Storm <cfoutput>#course_weather.currently.nearestStormDistance#</cfoutput> mile(s) bearing <img src="/golf_course_locator/assets/images/north_arrow.svg" style="height:1rem; margin-bottom: 6px; transform: rotate(<cfoutput>#course_weather.currently.nearestStormBearing#</cfoutput>deg);">&nbsp;</i><cfoutput>#course_weather.currently.nearestStormBearing#</cfoutput>&#730;</p>
        </div>
      </cfif>
    </div>
  
  </div>
  <!-- Card -->
</div>
      <h2 id="photo_heading">Course Photos</h2>
      <cfscript>
          course_photos = course_details.result.photos;
          photo_references = [];

          for (i=1; i <= arrayLen(course_photos); i=i+1) {
              ArrayAppend(photo_references,course_photos[i].photo_reference,"true");
          }

          for (i=1; i <= arrayLen(photo_references); i=i+1) {
              writeOutput('<img class=course_photo src=https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photoreference='&photo_references[i]&'&key='&apiKey&'>');
          }
      </cfscript>
</cfif>
</div>

<cfinclude template="footer.cfm">