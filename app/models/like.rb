class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :id,
      uniqueness: true
  validates :user_id,
      presence: true
  validates :post_id,
      presence: true
end
