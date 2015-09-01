ActiveAdmin.register Picture do
 belongs_to :product, parent_class: Product

  index do
    picture_columns = Picture.column_names - ['photo_updated_at', 'updated_at']
    picture_columns.each do |col|
      column col.to_sym
    end

    column 'Image' do |image|
      image_tag(image.photo.url(:small))
    end

    default_actions
  end
end
