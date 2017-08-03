// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  $('#get-search-form').on('click', function(e){
    e.preventDefault();
    var url = $(this).attr('href');
    $.ajax({
      url: url
    }).done(function(response){
      $('#search-target').append(response)
    });
  });
  $('#search-target').on('keyup', '#worker-search', function(e) {
    e.preventDefault();
    var data = e.target.value
    $.ajax({
      url: '/users/search',
      data: {search: data},
      method: 'POST'
    }).done(function(response){
      $('#search-container').html('')
      $('#search-container').append(response);
    });
  });
});
