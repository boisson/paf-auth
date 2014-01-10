class Proteste::Auth::UserSessionsController < ApplicationController
  skip_before_filter :can_access?
  skip_before_filter :login_required, :except => [ :destroy ]
  before_filter :login_required, :only => [ :destroy ]

  respond_to :html

  # omniauth callback method
  def create
    omniauth = env['omniauth.auth']

    user = Proteste::Auth::User.find_by_uid(omniauth['uid'])
    if not user
      # New user registration
      user = Proteste::Auth::User.new(:uid => omniauth['uid'])
    end
    user.info   = omniauth['info'].to_hash.symbolize_keys
    user.save(validate: false)

    # Currently storing all the info
    session[:user_id] = omniauth

    set_user_language if self.respond_to?('set_user_language')

    #flash[:notice] = I18n.t('devise.sessions.signed_in')
    
    redirect_to root_path
  end

  # Omniauth failure callback
  def failure
    flash[:notice] = params[:message]

  end

  # logout - Clear our rack session BUT essentially redirect to the provider
  # to clean up the Devise session from there too !
  def destroy
    Rails.cache.delete("proteste_permissions_#{current_user.id}")
    reset_session

    flash[:notice] = I18n.t('devise.sessions.signed_out')
    redirect_to "#{OmniAuth::Strategies::ProtesteAuthId::PROTESTE_AUTH_PROVIDER_URL}/users/sign_out"
  end
end
