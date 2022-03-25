class Post < ApplicationRecord
  belongs_to :user
  default_scope { order(created_at: :desc) }
  has_one_attached :post_image
  default_scope { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :post_image, length: { maximum: 255 }
  validates :only_user_id, presence: true
  validate :validate_picture

  def resize_picture
    self.picture.variant(resize: '200x200').processed
  end

  private

  def only_user_id
    memo.presence or picture.attached?
  end

  def validate_picture
    if picture.attached?
      if !picture.content_type.in?(%('image/jpeg image/jpg image/png image/gif'))
        errors.add(:picture, 'はjpeg, jpg, png, gif以外の投稿ができません')
      elsif picture.blob.byte_size > 5.megabytes
        errors.add(:picture, 'のサイズが5MBを超えています')
      end
    end
  end
end
