class Blog < ApplicationRecord
 
   belongs_to :user, optional: true
  paginates_per 7
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 140 }
   validates :deadline, presence: true
  validates :status, presence: true
   scope :sort_deadline, -> { order(deadline: :desc) }

   has_many :blog_labels, dependent: :destroy, inverse_of: :blog
  has_many :labels, through: :blog_labels, source: :label
  
   accepts_nested_attributes_for :blog_labels, allow_destroy: true
  

  enum priority:{"Low": 0, "Medium": 1, "High": 2}

  scope :sort_deadline, -> { order(deadline: :desc) }
  scope :sort_create, -> { order(created_at: :desc) }
   scope :sort_create, -> { order(created_at: :desc) }
  scope :sort_priority, -> { order(priority: :asc) }
  scope :search_title, -> (title){where('title Like ?',"%#{title}%")}
  scope :search_status, -> (status){where('status = ?',status)}
   scope :search_label, -> (label_id){ where(id: label_ids = BlogLabel.where(label_id: label_id).pluck(:blog_id))}

end


 

