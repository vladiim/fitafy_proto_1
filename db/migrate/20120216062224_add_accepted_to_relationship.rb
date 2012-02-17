class AddAcceptedToRelationship < ActiveRecord::Migration
  def change
    add_column :relationships, :accepted, :boolean, default: false

  end
end
