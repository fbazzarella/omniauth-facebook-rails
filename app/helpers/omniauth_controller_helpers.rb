module OmniauthControllerHelpers
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
