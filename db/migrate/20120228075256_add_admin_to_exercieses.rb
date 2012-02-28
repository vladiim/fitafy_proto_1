class AddAdminToExercieses < ActiveRecord::Migration
  def up
    add_column :exercises, :admin, :boolean, default: false
  end
  
  def down
    remove_column :exercises, :admin
  end
end
