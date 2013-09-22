module ApplicationHelper
  def sortable(column, title=nil)
    title ||=column.titleize
    css_class = column == sort_column ? "currecnt #{sort_direction}" :nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort=>column, :direction=>direction, :page=>nil), {:class=>css_class}
  end

  def destroy_link(path, other_classes="")
    classes = 'btn btn-danger btn-mini' + other_classes
    link_to("Destroy",
            path,
            method: 'delete',
            data: {confirm: 'Are you sure?'},
            class: classes
           )
  end
end
