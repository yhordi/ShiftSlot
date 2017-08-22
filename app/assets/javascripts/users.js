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
    var $this = $(this);
    if(!$this.hasClass('panel-collapsed')) {
      $this.parents('.panel').find('.panel-body').slideUp();
      $this.addClass('panel-collapsed');
      $this.find('i').removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
    } else {
      $this.parents('.panel').find('.panel-body').slideDown();
      $this.removeClass('panel-collapsed');
      $this.find('i').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
    }
  });
});
