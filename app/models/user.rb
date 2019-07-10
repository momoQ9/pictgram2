class User < ApplicationRecord
  validates :name, presence: true, length: {in: 1..15}
  validates :email, presence: true, format: {with: /\A\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*\z/}

  has_secure_password
  validates :password, presence: true, format: {with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,32}\z/}

  has_many :topics
  has_many :favorites
  has_many :favorite_topics, through: :favorites, source: 'topic'
  has_many :comments
end
