<cfinclude template="header.cfm">

<!-- Begin Page Content -->
<div class="container-fluid">
    <h3>Contact GolfAmbit Support</h3> 
    
    <cfif IsDefined("form.mailto") AND IsDefined("Form.Submit_Support") Is True>
    <cfif form.mailto is not "" AND form.body is not "">
    <cfset form_id = CreateUUID()>
    <cfmail to="#form.mailTo#" from="GolfAmbit Support<support@golfambit.com>" bcc="support@golfambit.com" subject="GolfAmbit Support Request #form_id#" type="html"> 
   
     
    <cfoutput>
    [LOCAL Server]
        <h1>GolfAmbit Support</h1>
        <p>Thank you for contacting GolfAmbit.</p>
        <p>The request id is #form_id#</p>
        <p>We will get in contact with you shortly when we have added the requested course.</p>
        <br>
        <h3>Support Request</h3>
        <p>#form.body#</p>
    </cfoutput>
    </cfmail>
    </cfif> 
    </cfif> 
    <p> 
    <form action = "contact.cfm" method="POST"> 
    <pre> 
    Your Email: <input type = "Text" name = "MailTo">
    <hr> 
    MESSAGE BODY: 
    <textarea name ="body" cols="40" rows="5" wrap="virtual"></textarea> 
    </pre> 
    <!--- Establish required fields. --->
    <input type = "hidden" name = "MailTo_required" value = "You must enter a recipient">
    <input type = "hidden" name = "Body_required" value = "You must enter some text"> 
    <p><input type = "Submit" name = "Submit_Support"></p> 
    </p> 
    </form>

</div>

<cfinclude template="footer.cfm">