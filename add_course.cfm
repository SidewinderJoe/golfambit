<html>
    <head>
        <title>Add a Golf Course</title>
    </head>

    <body>
        <style>
        div {
            text-align: center;
            max-width: 25%;
            margin-left: auto;
            margin-right: auto;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        #submit_button {
            margin-top: 15px;
        }
        </style>
        <div>
            <h2>Add a new Golf Course</h2>
            <form action="insertaction.cfm" method="post">
            Course Name:
                <input type="text" name="course_name" size="10" maxlength="100"><br>
            Zip Code:
                <input type="text" name="zip" size="5" maxlength="5"><br>
            Latitude:
                <input type="text" name="lat" size="10" maxlength="50"><br>
            Longitude:
                <input type="text" name="lng" size="10" maxlength="50"><br>
                <input type="Reset" value="Clear Form">
                <!-- Submit button -->
                <input type="Submit" value="Submit" id="submit_button">
            </form>
        </div>
    </body>
</html>

