class Entry < ApplicationRecord
  belongs_to :forum, :class_name => 'Forum'
end
