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
  
  def big_logo
    image_tag('logo.png', :alt => 'fitafy', :size => '200x200')
  end
  
  class ::WillPaginate::ActionView::LinkRenderer
    protected
    
    def html_container(html)
      tag :div, tag(:ul, html), container_attributes
    end
    
    def page_number(page)
      tag :li, link(page, page, rel: rel_value(page)), :class => ('active' if page == current_page)
    end
    
    def gap
      tag :li, link(super, '#'), :class => 'disabled'
    end
    
    def previous_or_next_page(page, text, classname)
      tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
    end
    
    def page_navigation_links(pages)
      will_paginate(pages, :class => 'pagination', :inner_window => 2, :outer_window => 0, :renderer => BootstrapLinkRenderer, :previous_label => '%larr;'.html_safe, :next_label => '&rarr;'.html_safe)
    end
  end
end
