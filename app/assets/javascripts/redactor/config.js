$(function () {
    var csrf_token = $('meta[name=csrf-token]').attr('content');
    var csrf_param = $('meta[name=csrf-param]').attr('content');
    var params;
    if (csrf_param !== undefined && csrf_token !== undefined) {
      params = csrf_param + "=" + encodeURIComponent(csrf_token);
    }

    $R.options = {
        buttonsTextLabeled: true
    };

    // Set global settings
    $R('.redactor', { 
        plugins: ['imagemanager', 'table'],
        imageManagerJson: '/redactor2_rails/images.json',
        imageUpload: '/redactor2_rails/images?' + params,
        fileUpload: '/redactor2_rails/files?' + params,
        lang: 'zh_cn' }
    );
    
    
    // Initialize Redactor
    $('.redactor').redactor();
});