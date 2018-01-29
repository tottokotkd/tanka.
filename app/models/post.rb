class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  validates :content,
      presence: true,
      length:{ in: 1..140, allow_blank: true }
end
