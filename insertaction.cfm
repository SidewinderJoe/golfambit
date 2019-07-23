<cfinsert datasource="courses" tablename="courses">

<body>
<h1>Golf Course Added</h1>
<cfoutput>You have added #Form.course_name# to the
    database.
</cfoutput>

<button><a href="/golf_course_locator/course_locator.cfm">Home</a></button>