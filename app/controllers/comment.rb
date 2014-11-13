get '/prayerrequests/:id' do |id|
  @prayerrequest = Prayerrequest.find(id)
  # Prevent user from going back to main feed if they are
  # commenting from this view
  session[:comment_show_page] = @prayerrequest.id
  erb :'comment/show'
end

post '/prayerrequests/:id/comments' do |id|
  @prayerrequest = Prayerrequest.find(id)
  user = User.find(session[:id])
  comment = user.comments.create(comment: params[:comment], prayerrequest: @prayerrequest)

  if request.xhr?
    erb :'entry/_comment', layout: false, locals: { entry: comment }
  else
    stay_or_leave_comment_show_page
  end
end
