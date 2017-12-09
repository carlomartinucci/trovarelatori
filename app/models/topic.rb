# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  theme_id   :integer
#  name       :string
#  keywords   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Topic < ApplicationRecord
  belongs_to :theme
  has_many :known_topics
  validates_presence_of :theme_id, :name
  validates_uniqueness_of :name, scope: [:theme_id]

  after_commit :update_keywords_delayed, on: :create

  include PgSearch

  pg_search_scope :search_by_keywords,
    against: :keywords,
    using: {
      tsearch: {
        any_word: true,
        prefix: true
      }
    }

  def known_topic(user)
    k = known_topics.where(user_id: user.id, topic_id: self.id).first_or_initialize
    # p "known_topic: #{k.attributes}"
    k
  end

  def self.known_topics(user)
    ids = self.all.pluck(:id)
    KnownTopic.where(user_id: user.id, topic_id: ids)
  end

  def update_keywords_delayed
    Topic.delay(run_at: 5.minutes.from_now).update_keywords(self.id, true)
  end

  def self.update_keywords(id, force = false)
    topic = Topic.find_by(id: id)
    return if topic.nil?

    p "setting keywords for topic #{topic.name}"
    keywords_list = [topic.name, topic.theme.name]
    if Rails.env.production? || force
      keywords_list += GoogleKnowledgeGraph.new(topic.name).list
    end
    keywords = keywords_list.map { |k| k.delete(',') }.join(',').downcase
    topic.update keywords: keywords
  end
end
