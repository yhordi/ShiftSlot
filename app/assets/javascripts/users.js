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
  if($button.data('preferred') == 'neutral') {
    $button.data('preferred', true);
    $button.removeClass('btn-default');
    $button.addClass('btn-success');
  } else if($button.data('preferred') == true) {
    console.log*'yoyoyo'
    $button.data('preferred', false);
    $button.removeClass('btn-success');
    $button.addClass('btn-danger');
  } else {
    $button.data('preferred', 'neutral')
    $button.removeClass('btn-danger')
    $button.addClass('btn-default');

  }
}
