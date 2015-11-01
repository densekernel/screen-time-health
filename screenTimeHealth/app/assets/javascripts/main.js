var loadFunc = function() {

    if ($("body").hasClass("analytics track")) {
      $(window).load(function() {
        console.log(gon.kid.unique_token + 'onload');
        $.ajax({
          url: '/analytics/start?unique_token='+gon.kid.unique_token
          // data: data,
          // success: success,
          // dataType: dataType
        });
      });
      $(window).on('beforeunload', function() {
        alert(gon.kid.unique_token + 'beforeunload');
        $.ajax({
          url: '/analytics/end?unique_token='+gon.kid.unique_token
          // data: data,
          // success: success,
          // dataType: dataType
        });
      })
    }

    $(".rotate-loading-icon-wrapper").css('padding-top', (($(window).height()-156)/2)+'px');
  
};

$(document).ready(loadFunc);
$(document).on('page:load', loadFunc);