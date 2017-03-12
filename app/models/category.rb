class Category < ActiveRecord::Base
  has_and_belongs_to_many :photos
  acts_as_tree

  scope :order_by_name, -> {order(:name)}


  # Recursively finds each ancestors name and concatenates with the parent name.
  def ancestors_name
    if parent
      "#{parent.ancestors_name} #{parent.name}:"
    else
      ""
    end
  end

  # Returns a concatenate string with all names of the parents with its own
  def long_name
    "#{ancestors_name} #{name}"
  end
end
