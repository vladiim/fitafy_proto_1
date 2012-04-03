class AddFromToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :sent_from, :integer

  end
end
