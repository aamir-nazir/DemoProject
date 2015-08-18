class AddAttachmentPhotoToPictures < ActiveRecord::Migration
  def self.up
    change_table :pictures do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_column :pictures, :photo_file_name
    remove_column :pictures, :photo_content_type
    remove_column :pictures, :photo_file_size
    remove_column :pictures, :photo_updated_at
  end
end
