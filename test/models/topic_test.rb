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

require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
