class Connection < ActiveRecord::Base
  belongs_to :reason, class_name: "Theorem", touch: true
  belongs_to :consequence, class_name: "Theorem", touch: true
  validates :reason_id, presence: true
  validates :consequence_id, presence: true
  
  has_many :stages, as: :stageable
end
