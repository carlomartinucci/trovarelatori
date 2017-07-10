class Theorem < ActiveRecord::Base
  belongs_to :claim
  has_many :connections, class_name:  "Connection",
                        foreign_key: "reason_id",
                        dependent:   :destroy,
                        inverse_of: :reason
  has_many :passive_connections, class_name:  "Connection",
                        foreign_key: "consequence_id",
                        dependent:   :destroy,
                        inverse_of: :consequence
  has_many :consequences, through: :connections
  has_many :reasons, through: :passive_connections
  belongs_to :argument

  has_many :favorites, as: :favoritable
  has_many :stages, as: :stageable
  

  validates :claim_id, presence: true

  default_scope { order(created_at: :desc) }

  def self.root_theorems
    self.select{|t| t.consequence_ids.empty? }
  end

  def support(other_theorem)
    connections.where(consequence_id: other_theorem.id).first_or_create
  end

  def unsupport(other_theorem)
    connections.find_by(consequence_id: other_theorem.id).destroy
  end

  def supporting?(other_theorem)
    consequences.include?(other_theorem)
  end

  def claim_value
    self.claim.try(:value)
  end

  def argument_name
    self.argument.try(:name)
  end

  def consequence
    self.consequences.last
  end

  def export
    {
      theorem_id: self.id,
      claim_id: self.claim_id,
      claim_value: self.claim_value
    }
  end

  def breadcrumb
    self.claim_value
  end

end
