class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { in: 6..20 }, on: :create
  has_many :post, dependent: :destroy

  has_one_attached :avatar
  has_secure_password

  before_create :set_current_password
  before_update :update_current_password

  def set_current_password
    self.current_password = password
  end

  def update_current_password
    self.current_password = password
  end
end
