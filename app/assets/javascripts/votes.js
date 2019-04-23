$(document).on('turbolinks:load', function(){
  $('.votes-links').on('ajax:success', function(e){
    var data = e.detail[0];
    var voteClass = '.' + data.klass + '-id-' + data.id
    $(voteClass + ' .votes-actions').toggleClass('hidden');
    $(voteClass + ' .votes-revoke').toggleClass('hidden');
    $(voteClass + ' .votes-rating').html('<i class="score">Score: ' + data.score + '</i>');
   })
});
