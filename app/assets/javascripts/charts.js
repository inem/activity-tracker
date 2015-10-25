var ready = function(){
  var sha1 = ""
  var sha2 = ""
  $(".elapsed-time").click(function(){
    sha1 = $(this).attr("child-tags").split(",")[0];
    sha2 = $(this).attr("child-tags").split(",")[1];
    
  });
}

$(document).ready(ready);
$(document).on("page:load", ready);
