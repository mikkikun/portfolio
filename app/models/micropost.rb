class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :iine_users, through: :likes, source: :user
  has_one_attached :picture
  default_scope { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :memo, length: { maximum: 255 }
  validates :only_user_id, presence: true
  validate :validate_picture

  def resize_picture
    self.picture.variant(resize: '100x100').processed
  end

  def iine(user)
    likes.create(user_id: user.id)
  end

  def uniine(user)
    likes.find_by(user_id: user.id).destroy
  end

  def iine?(user)
    iine_users.include?(user)
  end

  private

  def only_user_id
    time.presence or memo.presence or picture.attached?
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
