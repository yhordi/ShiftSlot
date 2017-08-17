$(document).ready(function(){

  $('#open-shifts').on('click', '#assign-worker', function(e){
    e.preventDefault();
    const url = $(this).attr('href');
    $.ajax({
      url: url
    }).done(function(response){
      $('#shifts').hide()
      $('#search-target').append(response)
    });
  });

  $('#open-shifts').on('submit', '#searchForm', e => {
    e.preventDefault();
  })

  $('#open-shifts').on('keyup', '#worker-search', function(e) {
    e.preventDefault();
    const data = $(this).parent().serialize()
    $.ajax({
      url: '/users/search',
      data: data,
      method: 'POST'
    }).done(function(response){
      $('#results').html('')
      $('#results').append(response);
    });
  });

  $('#search-container').on('submit', '#new_shift', function(e){
    e.preventDefault();
    const data = $(this).serialize();
    const url = $(this).attr('action')
    $.ajax({
      data: data,
      url: url,
      method: 'POST'
    }).done(function(response){
      $('#shifts-container').html('')
      $('#shifts-container').append(response);
    })
  })

  $('#get-shift-form').on('click', function(e){
    e.preventDefault();
    const url = $(this).attr('href');
    console.log(url)
    $.ajax({
      url: url
    }).done(function(response){
      $('#open-shifts-target').append(response)
    });
  });

  $('#shifts-container').on('submit', '#edit_shift', function(e) {
    e.preventDefault();
    const url = $(this).attr('action')
    const data = $(this).serialize()
    $.ajax({
      url: url,
      data: data,
      method: 'POST'
    }).done((response)=> {
      $(this).remove()
      $('#open-shifts').html('')
      $('#open-shifts').append(response)
    })
  });

});
