// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  $('.day').on('click', (e) => {
    e.preventDefault()
    determinePreferrence($(e.target));
  })
})

const determinePreferrence = ($button) => {
  // I'm trying to figure out how to determine if the button has been clicked
  // based on data available from the dom
  if($button.attr('data-preferred') == 'neutral') {
    $button.attr('data-preferred', true);
    $button.removeClass('btn-default');
    $button.addClass('btn-success');
    addHidden($button)
  } else if($button.attr('data-preferred') == 'true') {
    $button.attr('data-preferred', false);
    $button.removeClass('btn-success');
    $button.addClass('btn-danger');
    updateHidden('false', $button)
  } else {
    $button.attr('data-preferred', 'neutral')
    $button.removeClass('btn-danger')
    $button.addClass('btn-default');
    $(`#${$button.attr('name')}Attr`).remove()
  }
}

const addHidden = ($button) => {
  $('#new_preferred_day').prepend(`<input type='hidden' id=${$button.attr('name')}Attr name=days[${$button.attr('name')}] value=true/>`)
}

const updateHidden = (preference, $button) => {
  $(`#${$button.attr('name')}Attr`).attr('value', 'false')
}
