module ApplicationHelper
  
  def title
    base_title = "fitafy"
    if @title
      base_title + " | #{@title}"
    else
      base_title
    end
  end
  
  def logo
    image_tag('logo.png', :alt => 'fitafy', :size => '100x100')
  end
end
