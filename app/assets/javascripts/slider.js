var update_info = function() {
  var id = $('#days-slider').attr("data-id");
  var info_box = $("#activity-info");
  $('#days-slider').slider({
    range: "max",
    min: 1,
    max: 10,
    value: 5,
    slide: function( event, ui ) {
      info_box.hide("fast");
      $.ajax({
        type: "PUT",
        url: "/projects/" + id + "/update_info",
        data: { "days": ui.value },
        success: function(data){
          info_box.html(data);
          info_box.show("fast");
          $(".label-days").html(ui.value);
        }
      });
    }
  });
}
