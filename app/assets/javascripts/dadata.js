$(document).ready(function(){
    var defaultFormatResult = $.Suggestions.prototype.formatResult;
    var token  = "47dbc71166e2a1a763d332c1c663efac01e2ddbf";
    $city = $("#event_city");
    $location = $("#event_location");


    function setConstraints(sgt, kladr_id) {
        var restrict_value = false;
        var locations = null;
        if (kladr_id) {
            locations = { kladr_id: kladr_id };
            restrict_value = true;
        }
        sgt.setOptions({
            constraints: {
                locations: locations
            },
            restrict_value: restrict_value
        });
    }

    function formatResult(value, currentValue, suggestion, options) {
        var newValue = suggestion.data.city;
        suggestion.value = newValue;
        return defaultFormatResult.call(this, newValue, currentValue, suggestion, options);
    }

    function restrictAddressValue(suggestion) {
        var citySgt = $city.suggestions();
        var addressSgt = $location.suggestions();
        if (!citySgt.currentValue) {
            citySgt.setSuggestion(suggestion);
            var city_kladr_id = suggestion.data.kladr_id.substr(0, 13);
            setConstraints(addressSgt, city_kladr_id);
        }
    }

    function formatSelectedAdress(suggestion){
        var addressValue = makeAddressString(suggestion.data);
        return addressValue;
    }

    function makeAddressString(address){
        return join([
            address.street_with_type,
            join([address.house_type, address.house,
                address.block_type, address.block], " "),
            join([address.flat_type, address.flat], " ")
        ]);
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


    $location.suggestions({
        token: token,
        type: "ADDRESS",
        geoLocation: false,
        onSelect: restrictAddressValue,
        formatSelected: formatSelectedAdress
    });
});