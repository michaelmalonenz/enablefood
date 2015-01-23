# Load the Rails application.
require File.expand_path('../application', __FILE__)

secret = Rails.env.production? ? ENV['SECRET_TOKEN'] : "6477ba8b120228f462c9784b0c0188b27b3e4336a22cff2a7ef6b039880b484531a8424050f3b921085ec5338607aaaa1e3b4b"
FatFriday::Application.config.secret_key_base = secret

# Initialize the Rails application.
Rails.application.initialize!
