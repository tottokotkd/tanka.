class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content,
      presence: true,
      length:{ in: 1..140, allow_blank: true }
end
