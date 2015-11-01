var loadFunc = function() {

    console.log("yo");
    if ($("body").hasClass("analytics track")) {
      console.log("boo");
      $(window).load(function() {
        console.log(gon.kid.unique_token + 'onload');
        $.ajax({
          url: url,
          data: data,
          success: success,
          dataType: dataType
        });
      });
      $(window).on('beforeunload', function() {
        alert(gon.kid.unique_token + 'beforeunload');
        $.ajax({
          url: url,
          data: data,
          success: success,
          dataType: dataType
        });
      })
    }
    

           

  
};

$(document).ready(loadFunc);
$(document).on('page:load', loadFunc);