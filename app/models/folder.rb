# == Schema Information
#
# Table name: folders
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  slug       :string
#

class Folder < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_many :contents, dependent: :destroy
  validates :title, presence: true, length: { in: 3..9 }
end
