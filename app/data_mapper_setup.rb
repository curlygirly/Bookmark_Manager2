require 'data_mapper'

env = ENV[ 'RACK_ENV'] || 'development'

DataMapper.setup(:default, ENV['DATABASE_URL'] ||"postgres://localhost/bookmark_manager_#{env}")
# Saying set up with local DB like in test r go to remote DB set up with Heroku

require_relative 'bookmark_manager'

DataMapper.finalize

DataMapper.auto_upgrade!


