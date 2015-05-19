env = ENV[ 'RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

DataMapper.finalize

# Why we creating this file and why wasn't it mentioned in the tutorial?