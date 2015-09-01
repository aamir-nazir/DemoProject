ActiveAdmin.register Product do
 scope :ordered

 index do
   column :title
   column :body
   column "Created At", :created_at
   column :price, :sortable => :price do |product|
     div class: "price" do
       number_to_currency product.price
     end
   end

   column :reviews do |review|
     link_to "reviews", admin_product_reviews_path(review)
   end

   column :pictures do |picture|
     link_to "pictures", admin_product_pictures_path(picture)
   end

   column 'Image' do |product|
      product.pictures.build if product.pictures.blank?
      image_tag(product.pictures.first.photo.url(:xsmall))
   end

   default_actions
 end

end
