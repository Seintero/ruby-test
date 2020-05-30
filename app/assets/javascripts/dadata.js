$(document).ready(function(){
    var defaultFormatResult = $.Suggestions.prototype.formatResult;
    var token  = "47dbc71166e2a1a763d332c1c663efac01e2ddbf";
    $city = $("#event_city");
    $location = $("#event_location");


    function formatResult(value, currentValue, suggestion, options) {
        var newValue = suggestion.data.city;
        suggestion.value = newValue;
        return defaultFormatResult.call(this, newValue, currentValue, suggestion, options);
    }

    function join(arr ) {
        var separator = arguments.length > 1 ? arguments[1] : ", ";
        return arr.filter(function(n){return n}).join(separator);
    }
    function formatSelected(suggestion) {
        return suggestion.data.city;
    }

    $city.suggestions({
        token: token,
        type: "ADDRESS",
        hint: false,
        geoLocation: false,
        bounds: "city",
        constraints: {
            locations: { city_type_full: "город" }
        },
        formatResult: formatResult,
        formatSelected: formatSelected,
        onSelect: function(suggestion) {
        }
    });

});