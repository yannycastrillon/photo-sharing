var ready, set_position;

// Loop through and give each task a data-pos
// Attribute that holds its position in the DOM
set_position = function (){
  // All list item will have attribute of data-pos
  $('li').each(function(i){
    $(this).attr("data-pos",i+1);
  })
}

ready = function(){
  set_position();
  $("#sortable_thumbs").sortable();
  // after changes
  $("#sortable_thumbs").sortable().bind("sortupdate",function(e,ui){
    // array to store new order
    updated_order = []
    set_position();
    // populate the updated_order array with the new positions
    $('li').each(function(){
        $id = $(this).attr("id")
        $pos = $(this).attr("data-pos")
        updated_order.push({ id: $id.substring($id.length - 1), position: $pos });
    });
    // Build request to hit route /slideshows/update_slide_order with a PATCH
    var requestConfig = {type:"PATCH",
                         url: "/slideshows/update_slide_order",
                         data: {order: updated_order}
                        };
    $.ajax(requestConfig);
  });
}
$(document).ready(ready);
$(document).on("page:load",ready);
