// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  $('.day').on('click', (e)=>{
    console.log(e.target)
    determinePreferrence(e.target)
  })
})

const determinePreferrence = (button) => {
  // I'm trying to figure out how to determine if the button has been clicked
  // based on data available from the dom
  debugger
  if(button.dataset == undefined) {
    $(button).data('prefferred', true)
  }
}
