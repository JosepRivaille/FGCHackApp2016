class User < ApplicationRecord

  validates :id_tag, presence: true

  has_many :entries, class_name: 'Entry'

end
