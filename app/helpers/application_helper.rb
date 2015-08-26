module ApplicationHelper
  def user_authorized(id)
    user_signed_in? && current_user.id == id
  end

  def truncate_text(limit, text)
    text.truncate(limit, separator: ' ')
  end

  def select_tab_class(tab_name)
    params[:controller] == tab_name ? "selected" : ""
  end

  def user_photo(user,size)
    picture = user.picture || user.build_picture
    picture.photo.url(size)
  end

  def product_photo(product,size)
    picture = product.pictures.first || product.pictures.build
    picture.photo.url(size)
  end
end
