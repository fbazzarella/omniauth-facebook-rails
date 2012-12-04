require "omniauth-facebook-rails/engine"
if Rails.env.to_s == "test"
  require 'factory_girl'
  require File.expand_path('../../spec/factories', __FILE__)
end

module OmniauthFacebookRails
end
