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

class Content < ApplicationRecord
  belongs_to :folder
  belongs_to :user
  mount_uploader :content, ContentUploader
  validates :content, presence: true
  validate :content_size_validation
  validates_processing_of :content

  private
    def content_size_validation
      errors[:content] << "should be less than 500KB" if content.size > 0.5.megabytes
    end
end
