=begin
require "test_helper"

class ProductDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @detail_of_current_product = detail_of_current_products(:one)
  end

  test "should get index" do
    get detail_of_current_products_url
    assert_response :success
  end

  test "should get new" do
    get new_detail_of_current_product_url
    assert_response :success
  end

  test "should create detail_of_current_product" do
    assert_difference("ProductDetail.count") do
      post detail_of_current_products_url, params: { detail_of_current_product: { price: @detail_of_current_product.price, product_id: @detail_of_current_product.product_id, quantity: @detail_of_current_product.quantity } }
    end

    assert_redirected_to detail_of_current_product_url(ProductDetail.last)
  end

  test "should show detail_of_current_product" do
    get detail_of_current_product_url(@detail_of_current_product)
    assert_response :success
  end

  test "should get edit" do
    get edit_detail_of_current_product_url(@detail_of_current_product)
    assert_response :success
  end

  test "should update detail_of_current_product" do
    patch detail_of_current_product_url(@detail_of_current_product), params: { detail_of_current_product: { price: @detail_of_current_product.price, product_id: @detail_of_current_product.product_id, quantity: @detail_of_current_product.quantity } }
    assert_redirected_to detail_of_current_product_url(@detail_of_current_product)
  end

  test "should destroy detail_of_current_product" do
    assert_difference("ProductDetail.count", -1) do
      delete detail_of_current_product_url(@detail_of_current_product)
    end

    assert_redirected_to detail_of_current_products_url
  end
end
=end