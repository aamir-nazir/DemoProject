class Picture < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  has_attached_file :photo, :styles => { small: "150x150>", xsmall: "80x80>" }, default_url: "missing_:style.png"
  attr_accessible :name, :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates_attachment_size :photo, :less_than => 5.megabytes
end
