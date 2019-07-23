function getUrlVars() {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
        vars[key] = value;
    });
    return(vars);
}

var namezip = getUrlVars()["course"];
var couseContainer = document.getElementById("course_info");
var element = document.createElement("div");

console.log(namezip)
// var lat = getUrlVars()["lat"];
// var lng = getUrlVars()["lng"];

$.ajax({
        type: "GET",
        url: "/golf_course_locator/api/course_detail.cfc?method=getCourseDetails&namezip=" + namezip,
        dataType: "json",
        success: function(result) {
           element.innerHTML += 
           '<h3>' + result.name + '</h3>' +
            '<p>'+ result.formatted_address + '</p>'+
            '<p><a href="tel:' + result.formatted_phone_number + '">result.formatted_phone_number</a></p>' +
            '<p><a href="' + result.url + '"target="_blank">Directions</a></p>' +
            '<p><a href="' + result.website + '"target="_blank">Course Website</a></p>' +
            '<p>Rating: ' + result.rating + '</p>';

        },
        error: function() {
            console.log("error");
        }
        
});

couseContainer.appendChild(element);