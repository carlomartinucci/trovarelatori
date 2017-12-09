# == Schema Information
#
# Table name: themes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Theme < ApplicationRecord
  has_many :arguments
  has_many :favorites, as: :favoritable
  has_many :topics

  default_scope { order(created_at: :desc) }

  validates_presence_of :name
  validates_uniqueness_of :name

  def breadcrumb
    self.name
  end

  def known_topics(user)
    self.topics.known_topics user
  end
end
