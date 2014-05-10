$(function(){

 
  var unprocessed_file_ids = [];

  var display_unprocessed_files = function(){

    if (unprocessed_file_ids.length == 0) {
      clearTimeout(display_unprocessed_files);
      return;
    }
    
    // send the current unprocessed file ids to the server and check to see if any are nil (done)
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


        if (unprocessed_file_ids.length != 0) {
          setTimeout(display_unprocessed_files, 3000);
        }
      }
    });

}


$('#new_image').fileupload({
  dataType: 'json',
  sequentialUploads: true,
  start: function(e) {
    setTimeout(display_unprocessed_files, 3000);
  },
  add: function(e, data){

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
    done: function(e, data) {
      data.context.attr("data-image-id", data.result.image_id)
      unprocessed_file_ids.push(data.result.image_id);


      // var pollServerForImage = function() {
      //   // Code here
      //   $.ajax({
      //     dataType: 'json',
      //     type: 'GET',
      //     url: "/images/" + data.result.image_id, 
      //     success: function(response) {
      //       if (response.photo_processing == null) {
      //         var img = $("<img/>")
      //         .load(function() { 
      //           console.log("image loaded!"); 
      //           data.context.find('.processing').remove();
      //           data.context.append(img)
      //           img.hide().fadeIn();
      //           })
      //         .error(function() { console.log("error loading image"); })
      //         .attr("src", response.photo.thumb.url );
      //       } else {
      //         console.log("image not ready yet")
      //         setTimeout(pollServerForImage, 3000);
      //       }
      //     }
      //   });
      // };
      // setTimeout(pollServerForImage, 3000);
      
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