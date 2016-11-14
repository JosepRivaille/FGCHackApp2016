class User < ApplicationRecord
  has_many :entries, class_name: 'Entry'
end
