require "application_system_test_case"

class ProductDetailsTest < ApplicationSystemTestCase
  setup do
    @detail_of_current_product = detail_of_current_products(:one)
  end

  test "visiting the index" do
    visit detail_of_current_products_url
    assert_selector "h1", text: "Detail of current products"
  end

  test "should create detail of current product" do
    visit detail_of_current_products_url
    click_on "New detail of current product"

    fill_in "Price", with: @detail_of_current_product.price
    fill_in "Product", with: @detail_of_current_product.product_id
    fill_in "Quantity", with: @detail_of_current_product.quantity
    click_on "Create Detail of current product"

    assert_text "Detail of current product was successfully created"
    click_on "Back"
  end

  test "should update Detail of current product" do
    visit detail_of_current_product_url(@detail_of_current_product)
    click_on "Edit this detail of current product", match: :first

    fill_in "Price", with: @detail_of_current_product.price
    fill_in "Product", with: @detail_of_current_product.product_id
    fill_in "Quantity", with: @detail_of_current_product.quantity
    click_on "Update Detail of current product"

    assert_text "Detail of current product was successfully updated"
    click_on "Back"
  end

  test "should destroy Detail of current product" do
    visit detail_of_current_product_url(@detail_of_current_product)
    click_on "Destroy this detail of current product", match: :first

    assert_text "Detail of current product was successfully destroyed"
  end
end
