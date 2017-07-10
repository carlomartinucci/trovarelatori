class Topic < ActiveRecord::Base
  belongs_to :theme
  has_many :known_topics
  validates_presence_of :theme, :name

  # after_commit :set_keywords, on: :create

  include PgSearch

  pg_search_scope :search_by_keywords,
                  against: :keywords,
                  using: {
                    tsearch: {
                      any_word: true,
                      prefix: true
                    }
                  }


  def known_topic user
    k = known_topics.where(user_id: user.id, topic_id: self.id).first_or_initialize
    # p "known_topic: #{k.attributes}"
    k
  end

  def self.known_topics user
    ids = self.all.pluck(:id)
    KnownTopic.where(user_id: user.id, topic_id: ids)
  end


  def set_keywords(force=false)
    keywords_list = [self.name, self.theme.name]
    if Rails.env.production? || force
      keywords_list += GoogleKnowledgeGraph.new(self.name).list
    end
    keywords = keywords_list.map{|k|k.gsub(",","")}.join(",").downcase
    self.update keywords: keywords
  end
end
