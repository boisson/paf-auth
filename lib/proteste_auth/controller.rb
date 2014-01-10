require 'active_support'
module ProtesteAuth
  module Controller
    extend ActiveSupport::Concern

    included do
      before_filter :login_required
      helper_method :current_user
    end

    def login_required
      if !current_user
        respond_to do |format|
          format.html  {
            redirect_to '/auth/protesteauthid'
          }
          format.json {
            render :json => { 'error' => 'Access Denied' }.to_json
          }
        end
      else
        if 5.minutes.ago > last_touched_aca_at && current_user.alive?
          last_touched_aca_at!
        else
          # raise 'vish deveria ter ido pro deslogar'
          # redirect_to proteste_auth_logout_path
        end
      end
    end

    def last_touched_aca_at
      session[:last_touched_aca_at] ||= Time.now
    end

    def last_touched_aca_at!
      session[:last_touched_aca_at] = Time.now
    end

    def current_user
      return nil unless session[:user_id]
      @current_user ||= Proteste::Auth::User.find_by_uid(session[:user_id]['uid'])
    end
  end
end