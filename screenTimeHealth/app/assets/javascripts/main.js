var Vis = (function() {

  return {

     drawChart: function(myData) {

     
      }

  };

}());

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

    $(".dial").knob();

    if ($("body").hasClass("kid view")) {
      $(window).load(function() {

      var session_chartData = [];
      for (var property in gon.session) {
        if (gon.session.hasOwnProperty(property)) {
        // console.log(property)
        // console.log(gon.session[property])
        var subData = [];
        subData.push(property)
        $(gon.session[property]).each(function(index, val){
          subData.push(val)
        })
        // console.log("here")
        // console.log(subData)
        session_chartData.push(subData)
        }
      }

      console.log(session_chartData)
      });
    };
};

$(document).ready(loadFunc);
$(document).on('page:load', loadFunc);