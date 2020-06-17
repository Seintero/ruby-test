$(document).ready(function () {
    if ($('#events-main-filter').length > 0 && window.jQuery().datetimepicker) {
        $('#date_start').datetimepicker({
            format: 'DD-MM-YYYY',
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
})
;