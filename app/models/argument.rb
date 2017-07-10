class Argument < ActiveRecord::Base
  belongs_to :theme
  has_many :theorems
  has_many :favorites, as: :favoritable

  default_scope { order(created_at: :desc) }

  def theme_name
    theme.try(:name)
  end

  def ordered_theorems excluded_ids=[], theorems=nil
    theorems ||= self.theorems.includes(:claim, :consequences)
    root_theorems = theorems.select{|t| (t.consequence_ids - excluded_ids).empty? }
    excluded_ids += root_theorems.map(&:id)
    nested_theorems = {}
    root_theorems.each do |theorem|
      nested_theorems[theorem.id] = {value: theorem.claim_value, reasons: self.ordered_theorems(excluded_ids, theorem.reasons)}
    end
    nested_theorems
  end

  def import_theorems nested_theorems, root_theorem=nil
    nested_theorems.each do |root_id, root_hash|
      p "#{root_id}: #{root_hash}"
      claim = Claim.where(value: root_hash['value']).first_or_create
      theorem = Theorem.where(
        argument_id: self.id,
        claim_id: claim.id,
      ).first_or_create
      if root_theorem
        theorem.support(root_theorem)
      end
      if root_hash['reasons']
        self.import_theorems(root_hash.with_indifferent_access['reasons'], theorem)
      end
    end
  end

  def import_theorems_old theorems
    self.import_theorems_old_reasons theorems['reasons']
  end

  def import_theorems_old_reasons theorems, root_theorem=nil
    theorems.each do |hash|
      claim = Claim.where(value: hash['claim']).first_or_create
      theorem = Theorem.where(
        argument_id: self.id,
        claim_id: claim.id,
      ).first_or_create
      if root_theorem
        theorem.support(root_theorem)
      end
      if hash['reasons']
        self.import_theorems_old_reasons(hash['reasons'], theorem)
      end
    end
  end

  def root_theorems
    self.theorems.includes(:claim).select{|t| t.consequence_ids.empty? }
  end

  def breadcrumb
    self.name
  end

end
