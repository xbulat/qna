$(document).on('turbolinks:load', function(){
   $('.answers').on('click', '.edit-answer-link', function(e) {
       e.preventDefault();
       var answerId = $(this).data('answerId');
       console.log(answerId);
       $('div.edit-answer-' + answerId).toggleClass('hidden');
   })
});
