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

    $('#subscribe_form').on('submit', function(e){
        e.preventDefault();
        $.ajax({
            type: 'POST',
            context:this,
            url: this.action,
            dataType: 'json',
            data: $(this).serialize(),
            success: function(data){
              var message = JSON.stringify(data);
              $('#subscribe_form + .response').addClass(data.status).text(data.message);
            },
            error: function(data){
                console.log(JSON.stringify(data));
            }
        });
        return false;
    });
});