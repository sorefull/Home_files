# == Schema Information
#
# Table name: posts
#
#  id            :integer          not null, primary key
#  title         :string
#  text          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#  image         :string
#  about_welcome :boolean          default(FALSE)
#

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
