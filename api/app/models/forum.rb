class Forum < ApplicationRecord
  has_one :entertainment, :class_name => 'Entertainment', :foreign_key => 'name'
end
