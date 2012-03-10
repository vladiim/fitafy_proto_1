class Exercises::ChildPresenter
  # this presenter helps workout#new, workout#edit and booking#edit 
  # they each have instances of exercises that needs to be edited
  # the view this relates to is shared/exercises
  
  def initialize(title, model, parent_id, current_user)
    @title = title
    @model = model
    @parent_id = parent_id
    @user = current_user
    @n1 = -1
    @n2 = -1
    @alphabet = ("A".."Z").to_a
  end
  
  def parent
    if @parent_id == nil
        @parent = @user.workouts.new 
    else
      if @model == "booking"
        @parent = @user.bookings.find(@parent_id)
      else 
        @parent = @user.workouts.find(@parent_id)
      end
    end
  end
  
  def title
    @title 
  end
  
  def model
    @model
  end
  
  def body_parts
    @body_parts = Exercise::BODY_PARTS.sort
  end
  
  def alphabet
    @alphabet
  end
end