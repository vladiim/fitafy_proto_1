class ChangeUsers < ActiveRecord::Migration
  def up
    add_column :users, :role, :string, :null => false
    add_column :users, :admin, :boolean, :default => false
  end
  
  def down
    remove_column :users, :admin
    remove_column :users, :role
  end
end
