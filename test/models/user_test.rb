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
#  second_name            :string
#  gender                 :string
#  city                   :string
#  birthday               :datetime
#  public_email           :boolean          default(TRUE)
#  public_phone           :boolean          default(FALSE)
#  public_city            :boolean          default(TRUE)
#  public_birthday        :boolean          default(FALSE)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
