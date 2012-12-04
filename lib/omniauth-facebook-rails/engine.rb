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
    ActiveSupport.on_load(:action_controller) do
      helper_method :current_user, :user_signed_in?
      def save_return_path
        session[:return_path] = request.path
      end
      def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue ActiveRecord::RecordNotFound
        session.delete(:user_id)
        nil
      end

      def user_signed_in?
        !current_user.nil?
      end

      def authenticate!
        user_signed_in? || redirect_to((request.env["HTTP_REFERER"].blank?) ? root_path : :back, notice: "Voce precisa estar logado...")
      end
    end
  end
end
