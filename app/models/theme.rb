class Theme < ActiveRecord::Base
  has_many :arguments
  has_many :favorites, as: :favoritable
  has_many :topics

  default_scope { order(created_at: :desc) }

  def breadcrumb
    self.name
  end

  def known_topics user
    self.topics.known_topics user
  end

end
