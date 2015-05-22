
  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.create(email: params[:email],
                password: params[:password],
                password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/new'
    end
  end

  get '/users/reset_password' do
    erb :reset_password
  end

 post '/users/reset_password' do
  email = params[:email]
  user = User.first(email: email)
  user.password_token = (1..50).map{('A'..'Z').to_a.sample}.join
  user.password_token_timestamp = Time.now
  user.save
  flash[:notice] = 'Reset token sent - please check your email.'
  redirect to('/')
end

get '/users/new_password/:token' do
    @token = params[:token]
    user = User.first(password_token: @token)
    erb :'users/reset_password'
    # do we  need to specify the token element here?  :token?
end

post '/users/new_password' do
  @token = params[:token]
  user = User.first(password_token: @token)
  user.password = params[:password]
  user.password_confirmation = params[:password_confirmation]
  user.save
  #how does the server/database know that the password has been reset?
  redirect to('/sessions/new')
end


