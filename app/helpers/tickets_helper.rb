module TicketsHelper
  def sidebar_list_item(name, open, resolved, action, user=nil)
    link_text = "#{name}  -  Open: #{open} - Resolved: #{resolved}"
    if user.nil?
      content_tag :li do
        link_to :controller=>"tickets", :anchor => "#{name}", :action=>action  do
          link_text
        end
      end 
    else
      content_tag :li do
        link_to :controller=>"tickets", :action=>action, :user=>user  do
          link_text
        end
      end
    end
    
  end
end
