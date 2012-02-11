class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :trainer_id
      t.string :recipient_email
      t.string :token
      t.datetime :sent_at
      t.timestamps
    end
    add_index :invitations, :trainer_id
    add_index :invitations, :recipient_email
  end
end
