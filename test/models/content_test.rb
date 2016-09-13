# == Schema Information
#
# Table name: contents
#
#  id         :integer          not null, primary key
#  content    :string
#  folder_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  public     :boolean          default(FALSE)
#

require 'test_helper'

class ContentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
