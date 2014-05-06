$(function(){

  $('#new_image').fileupload({
    dataType: 'json',
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
        // SHOW PROCESSING GRAPHIC
        data.context.append('<div class="processing"></div>');
      }

    },
    done: function(e, data) {

        // START INTERVAL CODE
        var data_timer = setInterval(function(){

          $.ajax({
            dataType: "json",
            type: "GET",
            url: "/images/" + data.result.image_id, 
            success: function(response){
              console.log("photo_processing:" + response.photo.photo_processing)
              if (response.photo.photo_processing == null) {
                clearInterval(data_timer);
                  var img = $("<img/>")
                    .load(function() { 
                      console.log("image loaded correctly"); 
                      clearInterval(asset_timer);
                      data.context.find('.processing').remove();
                      data.context.append(img)
                      img.hide().fadeIn();
                      })
                    .error(function() { console.log("error loading image"); })
                    .attr("src", response.photo.thumb.url );
              }
            }
          });
        }, 3000);
      
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