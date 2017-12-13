// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(()=>{
  $('.authorize').on('click', (e) => {
    e.preventDefault();
    const url = '/assignments/' + e.target.value
    $.ajax({
      url,
      method: 'PUT'
    }).done((response)=>{
      const id =`#unauthorized-${response.assignment.id}`
      if(response.unauthorized_count > 0){
        $('#unauthorized-count')[0].innerText = response.unauthorized_count
      } else {
        $('.badge').remove()
        const panel = $(id).parent().parent().parent().parent()
        panel.removeClass('panel-danger')
        panel.addClass('panel-success')
      };
      $(id).parent().removeClass('list-group-item-danger')
      $(id).replaceWith('<p>Worker now authorized to work for this organization.</p>')
    })
  });
})
