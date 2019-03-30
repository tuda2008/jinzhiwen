$(function() {
  if ($('#new_device_uuid').length>0) {
    $.ajax({
      url: '/admin/device_uuids/new_uuid',
      type: 'POST',
      dataType:'json',
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      success: function(data) {
        $('#device_uuid_uuid').val(data.uuid);
        $('#device_uuid_auth_password').val(data.password);
        $('#device_uuid_code').val(data.code);
      },
      error: function() {
      }
    });
  }
});