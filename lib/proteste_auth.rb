module ProtesteAuth
  if defined?(Rails)
    require "proteste_auth/engine"
    require "proteste_auth/railtie"
  end
end

require 'action_view'
require "proteste_auth/controller"
require "proteste_auth/user/methods"