// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  $('.day').on('click', (e) => {
    determinePreferrence($(e.target));
  })
})

const determinePreferrence = ($button) => {
  // I'm trying to figure out how to determine if the button has been clicked
  // based on data available from the dom
  console.log($button.attr('data-preferred'))
  if($button.attr('data-preferred') == 'neutral') {
    $button.attr('data-preferred', true);
    $button.removeClass('btn-default');
    $button.addClass('btn-success');
  } else if($button.attr('data-preferred') == 'true') {
    $button.attr('data-preferred', false);
    $button.removeClass('btn-success');
    $button.addClass('btn-danger');
  } else {
    $button.attr('data-preferred', 'neutral')
    $button.removeClass('btn-danger')
    $button.addClass('btn-default');
  }
}
