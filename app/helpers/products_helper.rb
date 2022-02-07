module ProductsHelper
  def check_product_quantity(product)
    @product_being_check = product
    product_quantity(@product_being_check)

    if @product_quantity < 1
      content_tag(:div, "#{@product_being_check.name} is out of stock", class: ["grow", "h-14", "rounded-lg", "flex", "items-center", "justify-center", "bg-red-400", "transition", "duration-300", "ease-in-out", "hover:bg-red-500", "m-2", "order-1"])
    else
      content_tag(:div, "Stock: #{@product_quantity}", class: ["grow", "h-14", "rounded-lg", "flex", "items-center", "justify-center", "bg-green-400", "transition", "duration-300", "ease-in-out", "hover:bg-green-500", "m-2", "order-1"])
    end
  end

  def check_product_stock(product)
    if @product_quantity < 1
      capture do
        concat link_to('Show', show_product_url(@product_being_check), class: "grow h-14 rounded-lg flex items-center justify-center bg-sky-400 transition duration-300 ease-in-out hover:bg-sky-600 m-2 order-1")
        concat " "
        concat link_to('Enqueue', add_to_enqueue_cart_url(@product_being_check), data: { turbo_method: :post}, class: "grow h-14 rounded-lg flex items-center justify-center bg-yellow-700 transition duration-300 ease-in-out hover:bg-yellow-900 m-2 order-2")
      end
    else
      capture do
        concat link_to('Show', show_product_url(@product_being_check), class: "grow h-14 rounded-lg flex items-center justify-center bg-sky-400 transition duration-300 ease-in-out hover:bg-sky-600 m-2 order-1")
        concat " "
        concat link_to('Buy', add_to_shopping_cart_url(@product_being_check), data: { turbo_method: :post}, class: "grow h-14 rounded-lg flex items-center justify-center bg-green-700 transition duration-300 ease-in-out hover:bg-green-900 m-2 order-2")
      end
    end
  end

  def product_quantity(product)
    read_seller_with_tenant do
      @product_quantity = ProductDetail.find_by(product_id: product.id).quantity + ProductDetail.find_by(product_id: product.id).children.sum(:quantity)
    end
  end
end
