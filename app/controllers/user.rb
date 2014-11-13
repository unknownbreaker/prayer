# TESTING

get '/session-viewer' do
  session.inspect
end

# WELCOME ---------------------------------

get '/' do
  if current_user
    redirect to ('/prayerrequests')
  else
    erb :'welcome'
  end
end


# LOGIN ----------------------------------
get '/signin' do
  @login_username = session[:login_username]
  erb :'user/signin'
end

post '/signin' do
  user = User.find_by(username: params[:user][:username]).authenticate(params[:user][:password])


  if user
    session[:id] = user.id
    session[:login_username] = nil
    redirect to ('/prayerrequests')
  else
    set_error "Username or password is incorrect"
    session[:login_username] = params[:user][:username]

    redirect to ('/signin')
  end

end

# LOGOUT ----------------------------------
get '/signout' do
  session.delete(:id)
  redirect to ('/')
end


# SIGN UP / CREATE PROFILE ----------------------------------
get '/users/new' do
  if(session[:signup_username])
    @signup_username = session[:signup_username]
    session[:signup_username] = nil
  else
    @signup_username = ""
  end

  erb :'user/new'
end

post '/users' do
  user = User.new(params[:user])

  if user.save
    session[:id] = user.id
    redirect to('/prayerrequests')
  else
    set_error "Passwords do not match"
    session[:signup_username] = params[:user][:username]
    redirect to ('/users/new')
  end
end

# SHOW PROFILE ----------------------------------
get '/users/:id' do |id|
  user = User.find(id)
  @prayerrequests = user.prayerrequests

  if current_user == user
    @user = current_user
    @myself = true
  else
    @user = user
    @myself = false
  end
  erb :'user/show'
end


# EDIT PROFILE ----------------------------------
get '/users/:id/edit' do |id|
  @user = User.find(id)
  erb :'user/edit'
end

put '/users/:id' do |id|
  user = User.find(id)
  user.update(params[:user])
  redirect to ("/users/#{user.id}")
end


# DELETE PROFILE ----------------------------------
delete '/users/:id' do |id|
  User.find(id).destroy
  session[:id] = nil
  redirect to ('/')
end






















