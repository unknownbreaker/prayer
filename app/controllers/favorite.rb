post '/prayerrequests/:id/favorites' do |id|
  prayerrequest = Prayerrequest.find(id)
  current_user.favorites.create(favoriteable_type: prayerrequest.class.to_s, favoriteable_id: prayerrequest.id)
  if request.xhr?
    erb :'entry/_options_unfavorite', layout: false, locals: { entry: prayerrequest }
  else
    stay_or_leave_comment_show_page
  end
end

delete '/prayerrequests/:id/favorites' do |id|
  prayerrequest = Prayerrequest.find(id)
  current_user.favorites.find_by(favoriteable_type: prayerrequest.class.to_s, favoriteable_id: prayerrequest.id).destroy

  if request.xhr?
    erb :'entry/_options_favorite', layout: false, locals: { entry: prayerrequest }
  else
    stay_or_leave_comment_show_page
  end
end

post '/comments/:id/favorites' do |id|
  comment = Comment.find(id)
  current_user.favorites.create(favoriteable_type: comment.class.to_s, favoriteable_id: comment.id)

  if request.xhr?
    erb :'entry/_options_unfavorite', layout: false, locals: { entry: comment }
  else
    stay_or_leave_comment_show_page
  end
end

delete '/comments/:id/favorites' do |id|
  comment = Comment.find(id)
  current_user.favorites.find_by(favoriteable_type: comment.class.to_s, favoriteable_id: comment.id).destroy

  if request.xhr?
    erb :'entry/_options_favorite', layout: false, locals: { entry: comment }
  else
    stay_or_leave_comment_show_page
  end
end

get '/users/:id/favorites' do |id|
  @user = User.find(id)
  @favorite_prayerrequests = @user.favorites.where(favoriteable_type: "Prayerrequest").order("created_at DESC")
  @favorite_comments = @user.favorites.where(favoriteable_type: "Comment").order("created_at DESC")


  erb :'favorite/show'
end
