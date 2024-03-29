class Invitation < ActiveRecord::Base
  
  attr_accessible :trainer_id, :recipient_email
  
  belongs_to :trainer, class_name: "User", foreign_key: "trainer_id"
  has_one :recipient, class_name: "User"
  
  after_create :create_invited_client
  
  validates :recipient_email, presence: true
  
  validate :recipient_is_not_registered
  
  private
    
    def recipient_is_not_registered
      if User.find_by_email(recipient_email)
        errors.add :recipient_email, "is already a user of fitafy, no need to invite them!"
      end
    end
    
    def send_invitation(user)
      UserMailer.client_invitation(self, user).deliver
    end
    
    def create_invited_client
      @trainer = User.find(self.trainer_id)
      @email = self.recipient_email
        
      User.new do |user|
        user.username              = @email
        user.email                 = @email
        user.role                  = "invited_role"
        user.password              = @email
        user.password_confirmation = @email
        user.reset_perishable_token!
        user.invitation_id = self.id
        if user.save!
          Relationship.create(trainer_id: @trainer.id, client_id: @user.id)
          send_invitation(user)
        end
      end
    end
end
