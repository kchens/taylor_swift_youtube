class Product < ActiveRecord::Base
  has_many :actions
  has_many :users, through: :actions

  validates :name, :designer, :price, :category, presence: true
end
