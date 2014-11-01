class User < ActiveRecord::Base
  has_many :actions
  has_many :products, through: :actions

  validates :name, :email, :password,  presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }
end

