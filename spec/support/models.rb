require 'active_record'

module Proteste
  module Auth

    def self.table_name_prefix
      'proteste_auth_'
    end

    class User < ActiveRecord::Base
      store :info, accessors: [:name]
      attr_accessible :uid, :name, :login, :email, :info
      validates :uid, :login, :email, presence: true
    end
  end
end