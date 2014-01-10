# encoding: utf-8
require 'spec_helper'

describe Proteste::Auth::User do
  it 'should have a user' do
    user = Proteste::Auth::User.new(email: 'rtoledo@proteste.org.br', uid: '123-rtoledo')
    user.should be_valid
  end

  it 'should fail a user' do
    user = Proteste::Auth::User.new
    user.should be_invalid
    user.should have(2).errors
  end
end
