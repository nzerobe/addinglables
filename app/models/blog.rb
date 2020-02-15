class Blog < ApplicationRecord
 
   paginates_per 7
  
   belongs_to :user, optional: true
   has_many :blog_labels, dependent: :destroy, inverse_of: :blog
  has_many :labels, through: :blog_labels, source: :label
  
   accepts_nested_attributes_for :blog_labels, allow_destroy: true
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 140 }
   validates :deadline, presence: true
  validates :status, presence: true
   

  enum priority:{"Low": 0, "Medium": 1, "High": 2}
  
#   scope :sort_deadline, -> { order(deadline: :desc) }
#   scope :sort_deadline, -> { order(deadline: :desc) }
#   scope :sort_create, -> { order(created_at: :desc) }
#    scope :sort_create, -> { order(created_at: :desc) }
#   scope :sort_priority, -> { order(priority: :asc) }
#   scope :search_title, -> (title){where('title Like ?',"%#{title}%")}
#   scope :search_status, -> (status){where('status = ?',status)}
#    scope :search_label, -> (label_id){ where(id: label_ids = BlogLabel.where(label_id: label_id).pluck(:blog_id))}
  scope :sorted_by, -> (sort_option) do
    case sort_option
     when "deadline"
       order(deadline: :desc)
     when "priority"
       order(priority: :asc) 
     else
       order(created_at: :desc)
    end
  end

  scope :with_title, -> (title) do 
    next if title.blank?
    where("title LIKE ?", "%#{title}%")
  end

  scope :with_status, -> (status) do
    next if status.blank?
    where(status: status)
  end

  scope :with_label, -> (label_id) do
    next if label_id.blank?
    where(id: BlogLabel.where(label_id: label_id).pluck(:blog_id))
  end

end


 

