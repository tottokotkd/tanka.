class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    has_secure_password
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy

    validates :name,
        presence: true,
        length: { maximum: 30, allow_blank: true }
    validates :email,
        presence: true, length: { maximum: 255 },
        format: { with: VALID_EMAIL_REGEX, allow_blank: true },
        uniqueness: { allow_blank: true }
    validates :password,
        presence: true,
        length: { minimum: 6 },
        allow_nil: true

    before_save {email.downcase!}
end
