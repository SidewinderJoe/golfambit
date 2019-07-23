<!--- Email to user --->
<cfmail to="snidejere@gmail.com" from="GolfAmbit Support<support@golfambit.com>" bcc="support@golfambit.com" subject="GolfAmbit Support Request 12345" type="html">
[LOCAL Server]
<cfoutput>
    <h1>GolfAmbit Support</h1>
    <p>Thank you for contacting GolfAmbit.</p>
    <p>Your request id is 12345</p>
    <p>We will get in contact with you shortly when we have added the requested course.</p>
    <br>
    <h3>Support Request</h3>
    <p>Please add Piney Apple Golf Course.</p>
</cfoutput>
</cfmail>

<!--- Email to admin 
<cfmail to="support@golfambit.com" from="GolfAmbit Support<support@golfambit.com>" subject="Support Request 12345" type="html">
[LOCAL Server]
<cfoutput>
    <h1>GolfAmbit Support</h1>
    <p>The request id is 12345.</p>
    <p>Please add this course, Piney Apple Golf Course</p>
</cfoutput>
</cfmail>--->