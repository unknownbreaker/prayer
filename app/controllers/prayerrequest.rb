get '/prayerrequests' do
  @prayerrequests = Prayerrequest.all.order("created_at DESC").limit(20).includes(:user, :favorites, comments: [:favorites])

  session[:comment_show_page] = nil

  erb :'entry/index'

end


get '/prayerrequests/new' do
  erb :'entry/_prayerrequest_box'
end

post '/prayerrequests' do
  user = User.find(session[:id])
  prayerrequest = user.prayerrequests.create(prayerrequest: params[:prayerrequest])

  if request.xhr?
    erb :'entry/_prayerrequest', layout: false, locals: { prayerrequest: prayerrequest }
  else
    redirect to ('/prayerrequests')
  end
end
