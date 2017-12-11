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
      const id =`#unauthorized-${response.id}`
      $(id).parent().removeClass('list-group-item-danger')
      $(id).replaceWith('<p>Worker now authorized to work for this organization.</p>')
    })
  });
})
