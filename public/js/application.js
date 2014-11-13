$(document).ready(function() {

  // Prepends a newly created prayer request to the top
  // of the feed.
  $('.prayerrequest_box>form').on('submit', function(event) {
    event.preventDefault();
    var $form = $(event.target);
    var url = $form.attr('action');
    var type = $form.attr('method');
    var data = $form.find('textarea').val();

    $.ajax({
      url: url,
      type: type,
      dataType: 'text',
      data: { prayerrequest: data }
    }).done(function(response) {
      View.renderPrayerrequest(response);
      View.clearTextField($form);
    });


  });

  // Appends a newly created comment at the bottom of a
  // list of comments under that respective prayer request
  $('.feed').on('submit', '.comment_box>ul>li>form', function(event) {
    event.preventDefault();
    var $form = $(event.target);
    var url = $form.attr('action');
    var type = $form.attr('method');
    var data = $form.find('textarea').val();
    var current_comment = $form.parent().parent().parent().parent().find('.comments>ul');
    console.log(current_comment);

    $.ajax({
      url: url,
      type: type,
      dataType: 'text',
      data: { comment: data }
    }).done(function(response) {
      console.log(response);
      View.renderComment(response, current_comment);
      View.clearTextField($form);
    });


  });

  // Toggles favorite or unfavorite when clicked. Updates
  // the database with the creating or destroying them.
  $('.feed').on('submit', '.prayerrequest>.comments', function(event) {
    Control.toggleFavorite(event);
  });
  // Toggles favorite/unfavorite in the Favorites page.
  $('.favorites').on('submit', '.prayerrequest', function(event) {
    Control.toggleFavorite(event);
  });



});


Control = {
  toggleFavorite: function(event) {
    event.preventDefault();
    var $form = $(event.target);
    var url = $form.attr('action');
    if($form.find('input[name="_method"]').attr('value') == null) {
      type = $form.attr('method');
    } else {
      type = $form.find('input[name="_method"]').attr('value');
    }

    var $parent = $form.parent()
    console.log(url);
    console.log(type);

    $.ajax({
      url: url,
      type: type,
      dataType: 'text'
    }).done(function(response) {
      console.log(response);
      View.toggleFavorite(response, $parent);
    });
  }
}

View = {
  renderPrayerrequest: function(response) {
    $('.feed').prepend($(response).hide().fadeIn('slow'));
  },

  renderComment: function(response, current_comment) {
    response = '<li>' + response + '</li>'
    $(current_comment).append(response);
  },

  toggleFavorite: function(response, current_element) {
    $(current_element).empty().append(response);
  },

  clearTextField: function(form) {
    form.find('textarea').val("");
  }
}
