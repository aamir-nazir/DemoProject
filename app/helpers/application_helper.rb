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

  def flash_class flash_type
   { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" } [flash_type]
  end

  def cart_size
    return 0 unless cookies[:cart]
    cart = JSON.parse(cookies[:cart])
    cart.size
  end

  def in_cart(id)
    return false unless cookies[:cart]
    cart = JSON.parse(cookies[:cart])
    cart.include?(id.to_s)
  end

  def discounted_price
    @price * (100 - @discount)/100
  end
end
