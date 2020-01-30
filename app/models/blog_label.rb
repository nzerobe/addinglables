class BlogLabel < ApplicationRecord
  belongs_to :blog
  belongs_to :label
end