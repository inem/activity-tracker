var build_chart = function(){
  var chart_button = $(".user-chart");
  var chart_data;
  var ctx = document.getElementById("canvas").getContext("2d");

  var barChartData = {
    labels : [],
    datasets : [
      {
        fillColor : "rgba(220,220,220,0.5)",
        strokeColor : "rgba(220,220,220,0.8)",
        highlightFill: "rgba(220,220,220,0.75)",
        highlightStroke: "rgba(220,220,220,1)",
        data : []
      }
    ]
  };

  var myBar = new Chart(ctx).Bar(barChartData, {
    responsive : true
  });

  chart_button.click(function(){
      var u_id = $(this).attr("data-id");
      $.ajax({
        type: "GET",
        url: "users/" + u_id + "/chart_statistics",
        success: function(data){
          console.log(data);
          barChartData = {
        		labels : ["part1","part2","part3","part4"],
        		datasets : [
        			{
        				fillColor : "rgba(220,220,220,0.5)",
        				strokeColor : "rgba(220,220,220,0.8)",
        				highlightFill: "rgba(220,220,220,0.75)",
        				highlightStroke: "rgba(220,220,220,1)",
        				data : [data["part1"].length,data["part2"].length,data["part3"].length,data["part4"].length]
        			}
        		]
        	}
          //Clear and draw new Chart
          myBar.clear();
          myBar = new Chart(ctx).Bar(barChartData, {
            responsive : true
          });
          //
        }
      });
      if (typeof myBar !== 'undefined') {myBar.destroy()}
  });
}

var ready = function(){
  build_chart();
}


$(document).ready(ready);
$(document).on("page:load", ready);
