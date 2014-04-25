$(document).ready(function(){
  $('#new_image').fileupload({
    dataType: 'json',
    add: function(e, data){
      // $.each(data.files, function (index, file) {
      //   console.log('Added file: ' + file.name);
      //   data.context = $(".progress-bar div");
      //   data.submit();
      // });
      $('.progress_bar_wrapper').append($('.progress_context:first').clone());
      data.context = $('.progress_context:last');
      data.context.find($('.upload_file_name')).html(data.files[0].name);
      data.context.show('fade');
      data.submit();
    },
    progress: function (e, data) {
      if (data.context) {
        progress = parseInt(data.loaded / data.total * 100, 10);
        data.context.find($('.progress-bar')).find('div').css('width',  progress + '%').find('span').html(progress + '%');
      }
    }
  });
});