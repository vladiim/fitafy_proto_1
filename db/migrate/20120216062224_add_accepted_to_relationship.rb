class AddAcceptedToRelationship < ActiveRecord::Migration
  def change
    add_column :relationships, :accepted, :boolean, default: false
    add_column :relationships, :declined, :boolean, default: false
  end
end
