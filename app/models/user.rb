class User < ApplicationRecord
  has_secure_password
  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, length: { minimum: 3 }, confirmation: true
  delegate :name, to: :profile

  def mine?(object)
    id == object.user_id
  end
end
