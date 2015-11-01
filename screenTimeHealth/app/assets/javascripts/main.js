var Vis = (function() {

  return {

     drawHeavy: function() {

  var ctx = document.getElementById("heavy").getContext("2d");
    var heavyData = [
    {
        value: 51,
        color:"#F7464A",
        highlight: "#FF5A5E",
        label: "Good grades (As and Bs)"
    },
    {
        value: 47,
        color: "#46BFBD",
        highlight: "#5AD3D1",
        label: "Fair/poor grades (Cs or below)"
    },
    {
        value: 93,
        color: "#FDB45C",
        highlight: "#FFC870",
        label: "Have a lot of friends"
    },
    {
        value: 84,
        color: "#949FB1",
        highlight: "#A8B3C5",
        label: "Get along well with their parents"
    },
    {
        value: 72,
        color: "#4D5360",
        highlight: "#616774",
        label: "Have been happy at school this year"
    },
    {
        value: 60,
        color: "#D81B60",
        highlight: "#616774",
        label: "Are often bored"
    },
    {
        value: 33,
        color: "#CDDC39",
        highlight: "#616774",
        label: "Get into trouble a lot"
    },
    {
        value: 32,
        color: "#F4511E",
        highlight: "#616774",
        label: "Are often sad or unhappy"
    },

];
    var myNewChart = new Chart(ctx).PolarArea(heavyData, {
    segmentStrokeColor: "#000000"
    });
     
      },
      drawModerate: function() {

  var ctx = document.getElementById("moderate").getContext("2d");
    var moderateData = [
    {
        value: 65,
        color:"#F7464A",
        highlight: "#FF5A5E",
        label: "Good grades (As and Bs)"
    },
    {
        value: 31,
        color: "#46BFBD",
        highlight: "#5AD3D1",
        label: "Fair/poor grades (Cs or below)"
    },
    {
        value: 91,
        color: "#FDB45C",
        highlight: "#FFC870",
        label: "Have a lot of friends"
    },
    {
        value: 90,
        color: "#949FB1",
        highlight: "#A8B3C5",
        label: "Get along well with their parents"
    },
    {
        value: 81,
        color: "#4D5360",
        highlight: "#616774",
        label: "Have been happy at school this year"
    },
    {
        value: 53,
        color: "#D81B60",
        highlight: "#616774",
        label: "Are often bored"
    },
    {
        value: 21,
        color: "#CDDC39",
        highlight: "#616774",
        label: "Get into trouble a lot"
    },
    {
        value: 23,
        color: "#F4511E",
        highlight: "#616774",
        label: "Are often sad or unhappy"
    },

];
    var myNewChart = new Chart(ctx).PolarArea(moderateData, {
    segmentStrokeColor: "#000000"
    });
     
      },
            drawLight: function() {

  var ctx = document.getElementById("light").getContext("2d");
    var lightData = [
    {
        value: 66,
        color:"#F7464A",
        highlight: "#FF5A5E",
        label: "Good grades (As and Bs)"
    },
    {
        value: 23,
        color: "#46BFBD",
        highlight: "#5AD3D1",
        label: "Fair/poor grades (Cs or below)"
    },
    {
        value: 91,
        color: "#FDB45C",
        highlight: "#FFC870",
        label: "Have a lot of friends"
    },
    {
        value: 90,
        color: "#949FB1",
        highlight: "#A8B3C5",
        label: "Get along well with their parents"
    },
    {
        value: 82,
        color: "#4D5360",
        highlight: "#616774",
        label: "Have been happy at school this year"
    },
    {
        value: 48,
        color: "#D81B60",
        highlight: "#616774",
        label: "Are often bored"
    },
    {
        value: 16,
        color: "#CDDC39",
        highlight: "#616774",
        label: "Get into trouble a lot"
    },
    {
        value: 22,
        color: "#F4511E",
        highlight: "#616774",
        label: "Are often sad or unhappy"
    },

];
    var myNewChart = new Chart(ctx).PolarArea(lightData, {
    segmentStrokeColor: "#000000"
    });
     
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


Vis.drawHeavy();
Vis.drawModerate();
Vis.drawLight();

 
    };
    
};

$(document).ready(loadFunc);
$(document).on('page:load', loadFunc);