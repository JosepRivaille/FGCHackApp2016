class Entertainment < ApplicationRecord

  validates :name, presence: true
  validates :description, :length => { maximum: 140 }
  validates_inclusion_of :category, :in => %w(cinema sports music books games)
  validates_inclusion_of :score, :in => 0..10

  belongs_to :forum, :class_name => 'Forum', :foreign_key => 'id'

  def calculate_new_score(new_score)
    sum = self[:score] * self[:total_votes]
    sum += new_score
    sum / (self.total_votes + 1)
  end

end
