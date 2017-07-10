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

require 'test_helper'

class KnownTopicTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
