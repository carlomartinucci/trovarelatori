# == Schema Information
#
# Table name: themes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
