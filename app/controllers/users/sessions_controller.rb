class Users::SessionsController < Devise::SessionsController

  layout 'login'

  after_action :remove_notice, only: [:destroy, :create]

  def after_sign_out_path_for(_resource_or_scope)
    #root_path
    "https://google.com/accounts/logout"
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end

  private

    def remove_notice
      flash.discard(:notice)
    end

end