$(document).ready( function(){

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