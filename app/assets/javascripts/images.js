$(function(){

  var unprocessed_file_ids = [];
  var all_files_uploaded = false;

  var display_unprocessed_files = function(){

    $.ajax({
      dataType: 'json',
      type: 'POST',
      url: "/images/check_processed",
      data:{ file_ids: unprocessed_file_ids},
      success: function(response) {

        var image_ids = response.image_ids
        var image_urls = response.image_urls

        $.each(image_ids, function(index, id){
          var img = $("<img/>")
          .load(function() { 
            var thumbnail = $('div[data-image-id='+ id + ']')
            thumbnail.find('.processing').remove();
            thumbnail.append(img)
            img.hide().fadeIn();
          })
          .error(function() { console.log("error loading image"); })
          .attr("src", image_urls[index] );
        });
        
        unprocessed_file_ids = $(unprocessed_file_ids).not(image_ids).get();
        
        // if all images have been uploaded and if unprocessed array is 0
        console.log("unprocessed_file_ids.length: " + unprocessed_file_ids.length);
        console.log("all_files_uploaded: " + all_files_uploaded);
        if (unprocessed_file_ids.length != 0 || all_files_uploaded == false ) {
          console.log("fired setTimeout");
          setTimeout(display_unprocessed_files, 3000);
        }
      }
    });
  }


  $('#new_image').fileupload({
    
    dataType: 'json',
    sequentialUploads: true,
    start: function(e) {
      // start checking to see if files have been processed
      setTimeout(display_unprocessed_files, 3000);
    },
    add: function(e, data){
      console.log("data add" + data.total/1000 + "K")
      var template = $('<div class="thumbnail"><input type="text" value="0" data-width="48" data-height="48"'+
        ' data-fgColor="#0788a5" data-readOnly="1" data-bgColor="#3e4043" /></div>');

      data.context = template.appendTo($('.thumbnail_grid'));
      template.find('input').knob({
        inline: false
      });
      data.submit();

    },
    progress: function(e, data){

      // Calculate the completion percentage of the upload
      var progress = parseInt(data.loaded / data.total * 100, 10);

      // Update the hidden input field and trigger a change
      // so that the jQuery knob plugin knows to update the dial
      data.context.find('input').val(progress).change();

      if(progress == 100){
        data.context.find('canvas, input, div').remove();
        data.context.append('<div class="processing"></div>');
      }

    },
    progressall: function(e, data) {
      console.log("data total" + data.total/1000 + "K")
      var progress = parseInt(data.loaded / data.total * 100, 10);
      if(progress == 100){
        console.log("data loaded" + data.loaded)
        all_files_uploaded = true;
      }
    },
    done: function(e, data) {

      data.context.attr("data-image-id", data.result.image_id)
      unprocessed_file_ids.push(data.result.image_id);   

    }
  });

  // Helper function that formats the file sizes
  function formatFileSize(bytes) {
    if (typeof bytes !== 'number') {
      return '';
    }

    if (bytes >= 1000000000) {
      return (bytes / 1000000000).toFixed(2) + ' GB';
    }

    if (bytes >= 1000000) {
      return (bytes / 1000000).toFixed(2) + ' MB';
    }

    return (bytes / 1000).toFixed(2) + ' KB';
  }

});