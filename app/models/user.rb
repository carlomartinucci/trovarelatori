# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  admin                  :boolean          default(FALSE)
#  editor                 :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  phone                  :string
#  last_name              :string
#  gender                 :string
#  city                   :string
#  birthday               :datetime
#  public_email           :boolean          default(TRUE)
#  public_phone           :boolean          default(FALSE)
#  public_city            :boolean          default(TRUE)
#  public_birthday        :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :favorites
  has_many :journeys
  has_many :known_topics
  has_many :topics, through: :known_topics
  
  attr_writer :expertise
  def expertise
    @expertise ||= []
  end

  GENDERS = ["", "male", "famale"]
  before_validation :set_gender
  validates_inclusion_of :gender, in: GENDERS 

  def favorite_themes
    ids = self.favorites.where(favoritable_type: "Theme").pluck(:favoritable_id)
    Theme.where(id: ids)
  end

  def favorite_arguments
    ids = self.favorites.where(favoritable_type: "Argument").pluck(:favoritable_id)
    Argument.where(id: ids)
  end

  def favorite_theorems
    ids = self.favorites.where(favoritable_type: "Theorem").pluck(:favoritable_id)
    Theorem.where(id: ids)
  end

  def score scope=nil
    if scope.nil?
      known_topics = self.known_topics
    elsif scope.is_a? Topic::ActiveRecord_Relation
      known_topics = scope.known_topics self
    elsif scope.is_a? Theme
      known_topics = scope.known_topics self
    else
      raise NotImplementedError.new("please implement user.score scope when scope is a #{scope.class}")
    end
    known_topics.score
  end

  def correlated_searchs q=nil
    # TODO: se q non è nil, mostriamo cose veramente correlate con q. altrimenti questo è ok
    known_topics = self.known_topics.includes(:topic).where(knowledge: :interested)
    topics = Topic.where(id: known_topics.pluck(:topic_id))
    topics = Topic.limit(5).order("RANDOM()") if topics.none?

    themes = Theme.where(id: topics.pluck(:theme_id).uniq)
    potential_expert_ids = KnownTopic.where(topic_id: topics.pluck(:id)).pluck(:user_id).uniq
    experts = User.where(id: potential_expert_ids).where.not(id: self.id).sort_by{|u| - u.score(topics)}

    result = {}
    result[:topics] = topics
    result[:themes] = themes
    result[:experts] = experts
    result
  end

  def name
    "#{first_name} #{last_name}"
  end

  def public_name
    true
  end
  
  private
    def set_gender
      self.gender ||= ""
    end

end
