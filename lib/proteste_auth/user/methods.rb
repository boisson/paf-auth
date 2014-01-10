require 'proteste_auth/consumers'
module ProtesteAuth
  module User
    module Methods
      extend ActiveSupport::Concern
      included do
        store :info, accessors: [:name, :login, :email, :trigram, 
          :active_directory, :language, :company, :groups, 
          :applications_user_types_users, :blocked?, :access_locked?]
        attr_accessible :name, :login, :email, :trigram, :active_directory, 
        :language, :company, :groups, :blocked?, :access_locked?
        attr_accessible :info, :uid
      end

      def alive?
        # go to user
        true
      end

      module ClassMethods
      end
    end
  end
end