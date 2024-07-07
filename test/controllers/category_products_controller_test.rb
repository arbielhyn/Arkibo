require "test_helper"

class CategoryProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get category_products_index_url
    assert_response :success
  end
end
