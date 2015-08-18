class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :picture, :as => :imageable
  accepts_nested_attributes_for :picture

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :picture_attributes

  def profile_picture
    self.picture.present? ? self.picture : self.build_picture
  end

end
