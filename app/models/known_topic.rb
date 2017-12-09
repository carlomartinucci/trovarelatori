# == Schema Information
#
# Table name: known_topics
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  topic_id   :integer
#  knowledge  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class KnownTopic < ApplicationRecord
  includes Comparable
  belongs_to :user
  belongs_to :topic

  KNOWLEDGES = %w(interested private public debate)

  validates_uniqueness_of :topic, scope: [:user_id]
  validates_inclusion_of :knowledge, in: KNOWLEDGES
  validates_presence_of :topic, :user_id, :knowledge

  before_validation :set_default_knowledge
  after_create :destroy_if_unknown
  after_update :destroy_if_unknown

  def knowledge_unknown?
    self.knowledge == "unknown"
  end

  def knowledge_blank_or_unknown?
    self.knowledge.blank? || self.knowledge_unknown?
  end

  def score
    index = KNOWLEDGES.index self.knowledge
    index ? (index + 1) * 0.99 : 0
  end

  def <=> other_known_topic
    other_known_topic.score <=> self.score
  end

  def self.score
    self.all.map(&:score).sum
  end


  private

    def set_default_knowledge
      self.knowledge = "unknown" if !self.knowledge.in? KNOWLEDGES
    end

    def destroy_if_unknown
      self.destroy if self.knowledge_unknown?
    end

end
