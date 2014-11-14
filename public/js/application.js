$(document).ready(function() {

  // Prepends prayer request to top of the feed.
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

  // Appends comment to bottom of list of comments in main feed.
  $('.feed').on('submit', '.comment_box>ul>li>form', function(event) {
    Control.processComment(event);
  });

  // Appends comment to bottom of list of comments in user's profile page.
  $('.prayerrequests').on('submit', '.comment_box>ul>li>form', function(event) {
    Control.processComment(event);
  });

  // Appends comment to bottom of list of comments in favorite's page.
  $('.favorites').on('submit', '.comment_box>ul>li>form', function(event) {
    Control.processComment(event);
  });

  // Toggles favorite/unfavorite in the main feed. 
  $('.feed').on('submit', '.prayerrequest>.options', function(event) {
    Control.toggleFavorite(event);
  });

  // Toggles favorite/unfavorite for comment in the main feed.
  $('.feed').on('submit', '.prayerrequest>.comments', function(event) {
    Control.toggleFavorite(event);
  });

  // Toggles favorite/unfavorite for prayer request in the Favorites page.
  $('.favorite_prayerrequests').on('submit', '.prayerrequest>.options', function(event) {
    Control.toggleFavorite(event);
  });

  // Toggles favorite/unfavorite for comment in the Favorites page.
  $('.favorite_prayerrequests').on('submit', '.prayerrequest>.comments', function(event) {
    Control.toggleFavorite(event);
  });

  // Toggles favorite/unfavorite for comment in the comment section of Favorites page.
  $('.favorite_comments').on('submit', '.comment', function(event) {
    Control.toggleFavorite(event);
  });

  // Toggles favorite/unfavorite for prayer request in a user's profile page.
  $('.prayerrequests').on('submit', '.prayerrequest>.options', function(event) {
    Control.toggleFavorite(event);
  });

  // Toggles favorite/unfavorite for comment in a user's profile page.
  $('.prayerrequests').on('submit', '.prayerrequest>.comments', function(event) {
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
  }, 

  processComment: function(event) {
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
  }
}

View = {
  renderPrayerrequest: function(response) {
    $('.feed').prepend($(response).hide().fadeIn('slow'));
  },

  renderComment: function(response, current_comment) {
    response = '<li>' + response + '</li>'
    $(current_comment).append($(response).hide().fadeIn('slow'));
  },

  toggleFavorite: function(response, current_element) {
    $(current_element).empty().append(response);
  },

  clearTextField: function(form) {
    form.find('textarea').val("");
  }
}
