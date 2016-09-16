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

class Post < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates_processing_of :image
  validate :image_size_validation
  validates :title, presence: true, length: { in: 6..14 }
  validates :text, presence: true, length: { in: 10..300 }
  validates :image, presence: true

  private
    def image_size_validation
      errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
    end
end
