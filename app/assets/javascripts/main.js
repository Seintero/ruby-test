$(document).ready( function(){
    if($('#events-main-filter').length > 0) {
        $('#events-main-filter input[type="radio"]').on('change', function () {
           $(this).parent('form').submit();
        })
    }
});