$(document).on('turbolinks:load', function(){
   $('.questions').on('click', '.edit-question-link', function(e) {
       e.preventDefault();
       var questionId = $(this).data('questionId');
       console.log(questionId);
       $('tr.edit-question-' + questionId).toggleClass('hidden');
   })
});
