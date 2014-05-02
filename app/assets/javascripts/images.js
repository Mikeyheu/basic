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
      }

    },
    done: function(e, data) {

      console.log(data);

        // SHOW PROCESSING GRAPHIC
        data.context.append('<div class="processing"></div>');

        // START INTERVAL CODE
        var timer = setInterval(function(){
          $.ajax({
            dataType: "json",
            type: "GET",
            url: "/images/" + data.result.image_id, 
            success: function(response){
              console.log(response.photo);
              if (response.photo.thumb.url != null) {
                
                clearInterval(timer);
                data.context.find('.processing').remove();
                var img = $('<img />').attr('src', response.photo.thumb.url).load(function(){
                  data.context.append(img)
                }).hide().fadeIn();


              }
            }
          });
        }, 2000);

      
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