ActiveRecord::Schema.define do
  self.verbose = false

  create_table :proteste_auth_users, :force => true do |t|
    t.string :uid
    t.string :email
    t.string :login
    t.text :info
    t.timestamps
  end
end