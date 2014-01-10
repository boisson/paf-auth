require 'rails/railtie'
module ProtesteAuth
  class Railtie < Rails::Railtie
    initializer "proteste_auth.action_controller" do
      ActiveSupport.on_load(:action_controller) do
        include ProtesteAuth::Controller # ActiveSupport::Concern
      end
    end
  end
end