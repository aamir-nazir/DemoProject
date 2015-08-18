class Product < ActiveRecord::Base
  attr_accessible :body, :price, :title
end
