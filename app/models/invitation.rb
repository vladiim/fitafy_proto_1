class Invitation < ActiveRecord::Base
  
  belongs_to :trainer, class_name: "User", foreign_key: "trainer_id"
  has_one :recipient, class_name: "User"
  
  before_create :generate_token
  after_create :send_invitation, :create_user
  
  validates :recipient_email, presence: true
  
  validate :recipient_is_not_registered
  
  private
  
    def generate_token
      self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
    end
    
    def recipient_is_not_registered
      if User.find_by_email(recipient_email)
        errors.add :recipient_email, "is already a user of fitafy, no need to invite them!"
      end
    end
    
    def send_invitation
      UserMailer.client_invitation(self).deliver
    end
    
    def create_user
      @trainer = User.find(self.trainer_id)
      @email = self.recipient_email
      @user = User.new
      @user.username = @email
      @user.email = @email
      @user.role = "invited_role"
      @user.password = @email
      @user.password_confirmation = @email
      if @user.save!
        Relationship.create(trainer_id: @trainer.id, client_id: @user.id)
      end
    end
end
