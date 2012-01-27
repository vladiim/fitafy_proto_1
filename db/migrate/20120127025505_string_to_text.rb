class StringToText < ActiveRecord::Migration
  def up
    change_column :bookings, :message, :text
    change_column :exercises, :description, :text    
    change_column :exercises, :cues, :text        
    change_column :workouts, :description, :text        
  end

  def down
    change_column :workouts, :description, :text    
    change_column :exercises, :cues, :text        
    change_column :exercises, :description, :text   
    change_column :bookings, :message, :text    
  end
end
