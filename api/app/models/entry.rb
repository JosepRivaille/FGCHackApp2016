class Entry < ApplicationRecord
  belongs_to :forum, :class_name => 'Forum'
  belongs_to :user, :class_name => 'User'
end
