class Ticket < ActiveRecord::Base
  attr_accessible :name, :category, :date, :time, :place

def self.search(search)
  if search
    find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  else
    find(:all)
  end
end

	# def self.search(search)
	# 	search_condition = "%" + search + "%"
	# 	find(:all, :conditions => ['title LIKE ? OR description LIKE ?', search_condition, search_condition])
	# end
end
