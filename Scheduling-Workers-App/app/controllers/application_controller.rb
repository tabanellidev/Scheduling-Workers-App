class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  #Per accedere a tutte le funzioni è necessaria l'autenticazione
  before_action :authenticate_user!

  def admin?

    if current_user.role != 'admin'
      puts("test")
      not_authorized
    end

  end

  def not_authorized
    redirect_to :controller => "home", :action => 'notauthorized'
  end

end
