class Client
  include ActiveModel::Validations
  include ActiveModel::Conversion
  
  attr_accessor :email
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
  
  def trainer_creates_client(trainer)
    @email = self.email
    User.new do |user|
      user.username               = @email
      user.email                  = @email
      user.password               = Digest::SHA1.hexdigest([Time.now, rand].join)
      user.password_confirmation  = user.password
      user.role                   = "invited_role"
      user.reset_perishable_token!
      if user.save
        create_relationship(trainer, user)
      end
    end
  end
  
  def create_relationship(trainer, client)
    trainer.relationships.create!(client_id: client.id)
  end
end