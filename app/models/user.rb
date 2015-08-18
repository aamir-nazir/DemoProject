class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :picture, as: :imageable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :picture_attributes

  accepts_nested_attributes_for :picture, allow_destroy: true

  def profile_picture
    self.picture.present? ? self.picture : self.build_picture
  end

  def photo_url
    self.picture.photo.url
  end

end
