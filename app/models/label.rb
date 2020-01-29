class Label < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 20 }

  has_many :blog_labels
  has_many :blogs, through: :blog_labels, source: :blog

end