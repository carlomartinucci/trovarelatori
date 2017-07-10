class Claim < ActiveRecord::Base
  include PgSearch
  # include CreatedByUser
  belongs_to :user

  has_many :theorems

  pg_search_scope :search_by_value,
                  against: :value,
                  using: {
                    tsearch: {
                      any_word: true,
                      prefix: true
                    }
                  }

  default_scope { order(created_at: :desc) }

  def self.load_from_json
    json = Json.parse File.open('public/claims.json')
    p json.first
  end

  def breadcrumb
    self.value
  end
end
