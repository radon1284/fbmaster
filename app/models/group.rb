class Group < ActiveRecord::Base
  belongs_to :user
  validates_formatting_of :icon50, using: :url
end
