// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  $('#get-search-form').on('click', function(e){
    e.preventDefault()
    var url = $(this).attr('href')
    $.ajax({
      url: url
    }).done(function(response){
      $('#search-target').append(response)
    });
  });
});
