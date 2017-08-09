// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  $('#get-search-form').on('click', function(e){
    e.preventDefault();
    var url = $(this).attr('href');
    console.log(url)
    $.ajax({
      url: url
    }).done(function(response){
      $('#search-target').append(response)
      $('#get-search-form').hide()
    });
  });
  $('#get-shift-form').on('click', function(e){
    e.preventDefault();
    var url = $(this).attr('href');
    console.log(url)
    $.ajax({
      url: url
    }).done(function(response){
      $('#open-shifts-target').append(response)
    });
  });
  $('#search-target').on('keyup', '#worker-search', function(e) {
    e.preventDefault();
    var data = $(this).parent().serialize()
    $.ajax({
      url: '/users/search',
      data: data,
      method: 'POST'
    }).done(function(response){
      $('#search-container').html('')
      $('#search-container').append(response);
    });
  });
  $('#search-container').on('submit', '#new_shift', function(e){
    e.preventDefault();
    var data = $(this).serialize();
    var url = $(this).attr('action')
    $.ajax({
      data: data,
      url: url,
      method: 'POST'
    }).done(function(response){
      $('#shifts-container').html('')
      $('#shifts-container').append(response);
    })
  })
});
