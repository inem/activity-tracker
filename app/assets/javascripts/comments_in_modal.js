var ready = function(){
  var sha1 = "";
  var sha2 = "";
  var id = 0;
  $(".elapsed-time").click(function(){
    id = $(this).attr("data-id");
    sha1 = $(this).attr("child-tags").split(",")[0];
    sha2 = $(this).attr("child-tags").split(",")[1];
    console.log("SHA:",sha1, sha2);
    $.ajax({
      type: "GET",
      url: "users/" + id + "/commits_frequency",
      data: { "sha1": sha1, "sha2": sha2 },
      success: function(data){
        $(".modal-content").html(data);
        $(".modal").modal();
      }
    });
  });

}

$(document).ready(ready);
$(document).on("page:load", ready);
