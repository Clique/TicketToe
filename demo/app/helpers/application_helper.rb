module ApplicationHelper
	def sortable(query, column, title = nil)
	    title ||= column.titleize
	    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
	    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
	    link_to title, {:query => query, :sort => column, :direction => direction}, {:class => css_class}
  	end
end
