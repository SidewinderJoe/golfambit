<cfparam name="criteria" default="">
<cfparam name="checked_miles" default="">

<cfset cd = CreateObject("Component", "api.course_detail") />

<cfset result = cd.getCourseInfo(criteria="#criteria#", drive_miles="#checked_miles#") />


<cfscript>
    if (result[1].driving_miles != "") {
        arraySort(result, function (a, b){
            return lsParseNumber(a.driving_miles) - lsParseNumber(b.driving_miles);    
        });
    }
</cfscript>

<cfloop from="1" to="#arrayLen(result)#" index="i">
<cfscript>
    var courseName = result[i].course_name;
    var courseZip = result[i].zip;
    var courseLat = result[i].lat;
    var courseLng = result[i].lng;
    var coursenameZip = replace(courseName," ","%20","All")&"%20Golf%20Course%20"&replace(courseZip," ","%20","All");
</cfscript>
<cfoutput>
<div class="col-lg-4 col-md-6 card_container">
    <div class="card card-default h-100">
        <div class=card-header py-3>
            <h6 class=m-0 font-weight-bold text-primary>#result[i].course_name#</h6>
        </div>
        <div class=card-body>
            <cfif result[i].driving_miles == "">
                <p>#NumberFormat(result[i].distance, "0.0")# miles away</p>
            <cfelse>
                <p>#NumberFormat(result[i].driving_miles * 0.000621, "0.0")# miles away</p>
            </cfif>
        </div>
        <p style="text-align:center;">
            <a href="/golf_course_locator/course_details.cfm?course=#coursenameZip#&amp;lat=#courseLat#&amp;lng=#courseLng#">More Info</a>
        </p>
    </div>
</div>
</cfoutput>
</cfloop>