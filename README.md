# ProtesteAuth

Protect applications with access control login and authentication.
This gem provide a client side for single sign on.

## Installation

Add this line to your application's Gemfile:

    gem 'proteste_auth', git: 'git@github.com:proteste/paf-auth.git'

And then execute:

    $ bundle


## Install files and run migration

    # rails g proteste_auth:install
    # rake db:migrate


## This gem is updated and your project isn't?

Update the gem and run install without the first install process

    $ bundle update
    $ rails g proteste_auth:install --skip-first-install