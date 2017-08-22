$(document).ready(function(){
  $('#daysContainer').on('submit', '.updateDay', function(e) {
    e.preventDefault();
    let url = $(this).attr('action');
    let data = $(this).serialize();
    $.ajax({
      url: url,
      data: data,
      method: 'POST'
    }).done(function(response) {
      $(this).html(response);
    }.bind(this));
  });
  $('.clickable').on('click', function(e){
    console.log('hey')
    
  });
});
