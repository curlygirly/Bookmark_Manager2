require 'rest-client'

API_KEY = ENV['MAILGUN_API_KEY']
API_URL = "https://api:#{API_KEY}@api.mailgun.net/v2/app5aafb00aec2d4f6686f983c3940f9019.mailgun.org"

get '/email/:token' do
  token = params[:token]
  user = User.first(password_token: token)
  # user.first is looking up the user with that email address

  RestClient::Request.execute(
    url: API_URL + '/messages',
    method: :post,
    payload: {
      from: 'postmaster@app5aafb00aec2d4f6686f983c3940f9019.mailgun.org',
      to: 'jennifer.arad@gmail.com',
      subject: 'This is subject',
      text: 'This is text',
      html: 'https://secret-retreat-5607.herokuapp.com/users/reset_password/' + token,
      multipart: true
    },
    headers: {
      "h:X-My-Header": 'www/mailgun-email-send'
    },
    verify_ssl: false
  )
end