class Picture < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  attr_accessible :name
end
