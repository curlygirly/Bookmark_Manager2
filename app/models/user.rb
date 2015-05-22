require 'bcrypt'

class User



    include DataMapper::Resource

    property :id, Serial
    property :password_digest, Text
    property :email, String, unique: true
    property :password_token, Text
    property :password_token_timestamp, Time

    attr_reader :password
    attr_accessor :password_confirmation

    validates_uniqueness_of :email
    validates_confirmation_of :password

    def password=(password)
      @password = password
      self.password_digest = BCrypt::Password.create(password)
    end

    def self.authenticate(email, password)
      user = first(email: email)
      if user && BCrypt::Password.new(user.password_digest) == password
      user
      else
        nil
      end
    end

  end