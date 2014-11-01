class Action < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
end
