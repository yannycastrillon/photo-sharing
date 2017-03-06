class Photo < ActiveRecord::Base
  validates_presence_of :filename
  # validates_format_of :email, with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  # validates_lenght_of :name, within: 6..100
  has_many :slides
  has_and_belongs_to_many :categories
end
