class Review < ActiveRecord::Base
  attr_accessible :body
  belongs_to :product
  belongs_to :user
end
