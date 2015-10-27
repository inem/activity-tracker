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

      var dates_array = [];
      var commits_count = [];

      var u_id = $(this).attr("data-id");
      $.ajax({
        type: "GET",
        url: "users/" + u_id + "/chart_statistics",
        success: function(data){
          for (i in data) {
            dates_array.push(i);
            commits_count.push(data[i].length -1 )
          }
          barChartData = {
        		labels : dates_array,
        		datasets : [
        			{
        				fillColor : "rgba(220,220,220,0.5)",
        				strokeColor : "rgba(220,220,220,0.8)",
        				highlightFill: "rgba(220,220,220,0.75)",
        				highlightStroke: "rgba(220,220,220,1)",
        				data : commits_count
        			}
        		]
        	}
          //Clear and draw new Chart
          myBar.destroy();
          myBar = new Chart(ctx).Bar(barChartData, {
            responsive : true
          });
          //
        }
      });
  });
}

var ready = function(){
  build_chart();
}


$(document).ready(ready);
$(document).on("page:load", ready);
