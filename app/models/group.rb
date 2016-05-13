class Group < ActiveRecord::Base
  belongs_to :user
  validates_formatting_of :icon50, using: :url
  validates_formatting_of :icon, using: :url
  acts_as_votable 

  
end
