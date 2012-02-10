class Workout < ActiveRecord::Base
  
  after_create :manage_template_value
  
  attr_accessible :title, :description, :exercise_ids, :booking_id
  
  belongs_to :user
  
  has_and_belongs_to_many :exercises
  
  belongs_to :booking, :foreign_key => "booking_id"
  
  validates_presence_of :user_id, :on => :create, :message => "can't be blank"
  validates_presence_of :title, :on => :create, :message => "can't be blank"
  validates_presence_of :exercise_ids, :on => :create, :message => "can't be blank"
  
  validates :title, :length => { :maximum => 200 }
  
  scope :only_templates, select("id, title").where(template: true)
  
  protected
  
    def manage_template_value
      self.toggle!(:template) unless booking_id.nil?
    end
end
