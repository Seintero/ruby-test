$(document).ready( function(){

    if($('#events-main-filter').length > 0) {
        $('#events-main-filter input[type="radio"]').on('change', function () {
           $(this).parent('form').submit();
        })
    }

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

    if($('.select2').length > 0){
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
    } else {
        setTimeout(arguments.callee, 50);
    }

});