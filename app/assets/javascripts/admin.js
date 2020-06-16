(function ($) {
    "use strict";

    // Add active state to sidbar nav links
    var path = window.location.href; // because the 'href' property of the DOM element is the absolute path
    $("#layoutSidenav_nav .sb-sidenav a.nav-link").each(function () {
        if (this.href === path) {
            $(this).addClass("active");
        }
    });

    // Toggle the side navigation
    $("#sidebarToggle").on("click", function (e) {
        e.preventDefault();
        $("body").toggleClass("sb-sidenav-toggled");
    });


    if (window.jQuery().datetimepicker) {
        $('.datetime-input').val(moment($('.datetime-input').val(), "YYYY-MM-DD HH:mm").format("DD-MM-YYYY HH:mm")).datetimepicker({
            format: 'DD-MM-YYYY hh:mm',
            locale: 'ru',
            icons: {
                time: 'fa fa-clock-o',
                date: 'fa fa-calendar',
                up: 'fa fa-chevron-up',
                down: 'fa fa-chevron-down',
                previous: 'fa fa-chevron-left',
                next: 'fa fa-chevron-right',
                today: 'fa fa-check',
                clear: 'fa fa-trash',
                close: 'fa fa-times'
            }
        });
    }

    if ($('.select2').length > 0) {
        $('.select2').select2({
            language: "ru"
        });
    }

    if (typeof tinyMCE != 'undefined') {
        tinyMCE.init({
            selector: "textarea.tinymce",
            menubar: false,
            plugins: [
                'advlist autolink lists link image charmap print preview anchor',
                'searchreplace visualblocks code fullscreen',
                'insertdatetime media table paste code help wordcount'
            ],
            toolbar: 'undo redo | formatselect | ' +
                'bold italic backcolor | alignleft aligncenter ' +
                'alignright alignjustify | bullist numlist outdent indent | ' +
                'removeformat | help',
        });
    }


    if ($("input#event_city").length > 0) {
        var token = "47dbc71166e2a1a763d332c1c663efac01e2ddbf";
        var serviceUrl = "https://suggestions.dadata.ru/suggestions/api/4_1/rs";
        var type = "ADDRESS";
        var $city = $("#event_city");
        var $street = $("#event_location");

        function join(arr /*, separator */) {
            var separator = arguments.length > 1 ? arguments[1] : ", ";
            return arr.filter(function (n) {
                return n
            }).join(separator);
        }

        function cityToString(address) {
            return join([
                join([address.city_type, address.city], " "),
                join([address.settlement_type, address.settlement], " ")
            ]);
        }

        function formatSelected(suggestion) {
            return suggestion.data.city;
        }

        $city.suggestions({
            serviceUrl: serviceUrl,
            token: token,
            type: type,
            hint: false,
            bounds: "city-settlement",
            formatSelected: formatSelected,
        });

        $street.suggestions({
            serviceUrl: serviceUrl,
            token: token,
            type: type,
            hint: false,
            bounds: "street-house",
            constraints: $city,
        });
    }




})(jQuery);