class Entertainment < ApplicationRecord
  belongs_to :forum, :class_name => 'Forum', :foreign_key => 'id'
end
