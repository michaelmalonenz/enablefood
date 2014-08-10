window.global = {};

$(document).ready( () ->
  $('.alert').delay(2500).fadeOut();
);

preload = (arrayOfImages) ->
  window.addEventListener('load', () ->
      $(arrayOfImages).each(() ->
        $('<img />').attr('src', this).appendTo('body').hide();
      );
  , false)


#Pre-load the background image for the transparent black, so that the UI doesn't suffer when the image request is sent
#at the same time as the main request spawning the dialog (Jobs Export!)
preload([
  '/assets/blackTransparentBg.png'
]);

global.askYesNoQuestion = (title, question, callback) ->
  popup = $("<div class='popup'>
                 <div>
                    <div class='popup-title'>" + title + "</div>
                    <p></p>
                    <a href='javascript:void(0)' class='button' data-val='false' tabindex='1'>No</a>
                    <a href='javascript:void(0)' class='button' data-val='true' style='margin-right:10px;' tabindex='2'>Yes</a>
                    <div style='clear:both;'></div>
                 </div>
              </div>");
  popup.prependTo("body");

  box = $("body > .popup").first()

  #adding question this way to allow jquery objects with bound events etc to be displayed in popup instead of just html string
  box.find("p").append(question)
  #box.children().css({ marginTop: -box.children().outerHeight(false) })
  #box.hide()
  box.find(".button").click(() ->
    res = $(this).data("val")
    box.fadeOut(() ->
      #invoke callback before popup remove in case callback wants to do something before removal (e.g. Devices change group)
      try callback(res)
      finally $(this).closest(".popup").remove()
    )
  )
  box.fadeIn()
