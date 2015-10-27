var build_chart = function(){
  var chart_button = $(".user-chart");
  var chart_data;

  chart_button.click(function(){
      var u_id = $(this).attr("data-id");
      $.ajax({
        type: "PUT",
        url: "users/" + u_id + "/chart_statistics",
        success: function(data){
          console.log(data);
          var barChartData = {
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
          var ctx = document.getElementById("canvas").getContext("2d");
          window.myBar = new Chart(ctx).Bar(barChartData, {
            responsive : true
          });
        }
      });

  });
}

var ready = function(){
  build_chart();
}


$(document).ready(ready);
$(document).on("page:load", ready);
