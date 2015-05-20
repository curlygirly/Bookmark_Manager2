env = ENV[ 'RACK_ENV'] || 'development'

DataMapper.setup(:default, ENV['DATABASE_URL'] ||"postgres://localhost/bookmark_manager_#{env}")
# Saying set up with local DB like in test r go to remote DB set up with Heroku

DataMapper.finalize

