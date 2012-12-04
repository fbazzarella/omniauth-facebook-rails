module OmniauthFacebookRails
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
    end
    initializer "omniauth_facebok_rails.add_facebook" do |app|
      require 'omniauth'
      require 'omniauth/facebook'
      app.middleware.use OmniAuth::Builder do
        provider :facebook, ENV['FACEBOOK_APP_KEY'], ENV['FACEBOOK_APP_SECRET'], :scope => "email"
      end
    end
    initializer "omniauth_facebook_rails.add_helpers" do |app|
      ActionController::Base.send :include, OmniauthControllerHelpers
    end
  end
end
