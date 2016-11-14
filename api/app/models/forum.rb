class Forum < ApplicationRecord
  has_one :entertainment, :class_name => 'Entertainment', :foreign_key => 'id'
  has_many :entries, :class_name => 'Entry', :foreign_key => 'id'
end
