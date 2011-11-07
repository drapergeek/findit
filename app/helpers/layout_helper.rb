# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end
  
  def show_title?
    @show_title
  end
  
  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end
  
  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

  def top_menu_link(name, path, controller_paths, current_controller)
    if controller_paths.include?(current_controller.downcase)
     content_tag :li, :class=>"active" do
       link_to name, path
     end 
    else
     content_tag :li do
       link_to name, path
     end 
    end
  end

  def tab_link(name, path, controller_name, current_controller, first=nil)
    if current_controller.downcase == controller_name.downcase 
      content_tag :li, :class=>"active #{first}" do
        link_to name, path
      end
    else
      content_tag :li, :class=>"#{first}" do
        link_to name, path
      end
    end
  end
end
