document.getElementById("course_locator").innerHTML = localStorage.getItem("courseList");

//Google Maps Search Field
function initialize() {
    var input = document.getElementById('searchTextField');
    var options = {
    componentRestrictions: {country: 'us'}
    };
    var autocomplete = new google.maps.places.Autocomplete(input, options);
    google.maps.event.addListener(autocomplete, 'place_changed', function () {
        var place = autocomplete.getPlace();
        document.getElementById('cityLat').value = place.geometry.location.lat();
        document.getElementById('cityLng').value = place.geometry.location.lng();
    });

}

function roundUp(num, precision) {
    precision = Math.pow(10, precision)
    return Math.ceil(num * precision) / precision

}

function check() {
   var checked = document.getElementById("customSwitch1").checked;
   return checked;
}

function mileValue() {
    var milesEntered = document.getElementById("mileRadius").value;
    if (milesEntered > 50 || milesEntered <= 0) {
       document.getElementById("mileRadius").value = "";
    }
}


google.maps.event.addDomListener(window, 'load', initialize);

//Prevent Enter from being clicked for Search Field
$("#searchTextField").keypress(function(e){
    if(e.keyCode === 13){
        e.preventDefault();
    }
});

$("#search_button").click(function(e) {
    document.getElementById("course_locator").innerHTML = "";
    document.getElementById("course_counter").innerHTML = "";
    var loader = document.getElementById("loader");
    loader.style.display = "block";
    var cityLat = document.getElementById('cityLat').value;
    var cityLng = document.getElementById('cityLng').value;
    var mileRadius = document.getElementById("mileRadius").value;
    var container = document.getElementById('container');
    var course_counter = document.getElementById('course_counter');
    var element = document.createElement("div");
    var criteria = cityLat + "," + cityLng + "," + mileRadius;
    var checked_miles = false;
    if (check() == true) {
        checked_miles = true;
    } else {
        checked_miles = false;
    }
    e.preventDefault();

    $.post("course_locator.cfm",
        { criteria:criteria, checked_miles:checked_miles},
        function(data, status){
            loader.style.display = "none";
            $("#course_locator").html(data);
            var coursesFound = document.querySelectorAll(".card_container").length;
            var counter_element = document.createElement('div');
            counter_element.innerHTML += '<p>' + coursesFound + ' Course(s) found</p>';
            course_counter.appendChild(counter_element);
            localStorage['courseList'] = $("#course_locator").html();
    });
});
