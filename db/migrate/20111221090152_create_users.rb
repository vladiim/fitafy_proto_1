class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :null => false
      t.string :email, :null => false
      t.string :crypted_password, :null => false
      t.string :password_salt, :null => false
      t.string :persistence_token
      t.string :perishable_token

      t.timestamps
    end
    add_index :users, :username
    add_index :users, :email
    add_index :users, :persistence_token
    add_index :users, :perishable_token
  end
end
