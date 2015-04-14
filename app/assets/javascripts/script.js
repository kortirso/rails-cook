function correction() {
  $('.down').each(function() {
    var data = $('.up').first().width();
    $(this).css('width', data);
    $(this).css('height', data);
  });
}

$(function() {
  var nestedForm;
  nestedForm = $('.ingrid').last().clone();
  $('.duplicate').click(function(e) {
    var formsOnPage, lastNestedForm, newNestedForm;
    e.preventDefault();
    lastNestedForm = $('.ingrid').last();
    newNestedForm = $(nestedForm).clone();
    formsOnPage = $('.ingrid').length;
    $(newNestedForm).find('label').each(function() {
      var newLabel, oldLabel;
      oldLabel = $(this).attr('for');
      newLabel = oldLabel.replace(new RegExp(/_[0-9]+_/), "_" + formsOnPage + "_");
      $(this).attr('for', newLabel);
    });
    $(newNestedForm).find('select, input').each(function() {
      var newId, newName, oldId, oldName;
      oldId = $(this).attr('id');
      newId = oldId.replace(new RegExp(/_[0-9]+_/), "_" + formsOnPage + "_");
      $(this).attr('id', newId);
      oldName = $(this).attr('name');
      newName = oldName.replace(new RegExp(/\[[0-9]+\]/), "[" + formsOnPage + "]");
      $(this).attr('name', newName);
    });
    $(newNestedForm).insertAfter(lastNestedForm);
  });

  $('#comment_body').keyup(function() {
    if($(this).val().length > 0) {
      $('#add_comment').removeClass('disabled');
    }
    else {
      $('#add_comment').addClass('disabled');
    }
  });

  $('.cat').mouseenter(function() {
    $(this).find('.down').fadeIn(500);
  }).mouseleave(function() {
    $(this).find('.down').fadeOut(750);
  });

  $(window).resize(function() {
    correction();
  });

  $('#recipe_navigator').click(function(e) {
    e.preventDefault();
    if($(this).find('span').hasClass('glyphicon-chevron-down')) {
      $('.panel-body').slideDown(500);
      $(this).find('span').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
      correction();
    }
    else {
      $('.panel-body').slideUp(500);
      $(this).find('span').addClass('glyphicon-chevron-down').removeClass('glyphicon-chevron-up');
    }

  });
});