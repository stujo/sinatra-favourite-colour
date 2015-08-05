$(function(){

  function vote_update(e, form, select){
    var $target, url, $card, $counter, $button, guess;
    e.preventDefault();
    e.stopPropagation();
    
    $target = $(e.target);

    url = form.attr('action');

    $card = $target.closest('.color-card');
    $counter = $card.find('.vote-count');
    $button = $target.find('.vote-button')

    if(select){
      $card.addClass('color-selected z-depth-5');
      $card.removeClass('color-unselected');
      guess = parseInt($counter.text()) + 1;
    } else {
      $card.removeClass('color-selected z-depth-5');
      $card.addClass('color-unselected');
      guess = parseInt($counter.text()) - 1;
    }

    $counter.html(guess);

    var promise = $.ajax({
      url : url,
      type: 'post',
      dataType: 'json'
    });

    promise.done(function(json){
      $counter.html(json.vote_count)
    });    
  }

  $('#color_voting').on('submit', '.color-vote', function(e){
    vote_update(e, $(this), true);
  });
  $('#color_voting').on('submit', '.color-unvote', function(e){
    vote_update(e, $(this), false);
  });  
});