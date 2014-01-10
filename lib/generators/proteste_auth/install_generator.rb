require 'rails/generators'
require 'active_support'
module ProtesteAuth
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Install files for authentication"
      source_root File.expand_path('../templates', __FILE__)
      class_option :first_install, :type => :boolean, :default => true, desc: 'install of user model, app_id and app_secret.'

      def generate_user_model
        if options.first_install?
          puts "\n\n- Generating Proteste::Auth::User model"
          generate('model', "Proteste::Auth::User uid:string info:text")
        end
      end

      def fix_user_model
        if options.first_install?
          content_for_model = []
          content_for_model << "include ProtesteAuth::User::Methods"

          content_for_model.each do |c|
            inject_into_class 'app/models/proteste/auth/user.rb', Proteste::Auth::User do
              "\t#{c}\n"
            end
          end
        end
      end

      def configuring_access_control_2_url
        # api settings
        application(nil, :env => "development") do
          "config.acccess_control_2_url = 'http://localhost:3000'"
        end

        application(nil, :env => "production") do
          "config.acccess_control_2_url = 'http://localhost:3000'"
        end

        application(nil, :env => "test") do
          "config.acccess_control_2_url = 'http://localhost:3000'"
        end
      end

      def add_route
        route("match '/auth/:provider/callback', :to => 'proteste/auth/user_sessions#create'")
        route("match '/auth/failure', :to => 'proteste/auth/user_sessions#failure'")
        route("match '/logout', :to => 'proteste/auth/user_sessions#destroy', as: :proteste_auth_logout")
      end

      def include_lib_folder
        puts "\n\n- Adding lib on initialization"
        application do
          'config.autoload_paths += %W(#{config.root}/lib)'
        end
      end

      def copy_initializers
        if options.first_install?
          @random_app_id      = SecureRandom.hex(23)
          @random_app_secret  = SecureRandom.hex(43)
          puts "\n\n============= Attention"
          puts "- Store this values save on Application entity in Access Control 2"
          puts "- Random App Id:      #{@random_app_id}"
          puts "- Random App Secret:  #{@random_app_secret}"

          puts "\n\n- Copying middleware to config/initializers"
          template('config/initializers/proteste_auth_middleware.rb', File.join('config/initializers', "proteste_auth_middleware.rb"))
        end
      end

      def copy_app
        puts "\n\n- Copying app folder"
        directory('app')
      end

      def copy_lib
        puts "\n\n- Copying lib folder"
        directory('lib')
      end
    end
  end
end