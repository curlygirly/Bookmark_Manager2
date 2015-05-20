post '/set-flash' do
  flash[:notice] = "Thanks for signing up!"
  flash[:notice]
  flash.now[:notice] = "Thanks for signing up!"
end