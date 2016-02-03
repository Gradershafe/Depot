require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
      @update = { 
                  title: 'Lorem Ipsum',
                  description: 'Wibbles are fun!', 
                  image_url: 'lorem.jpg', 
                  price: 19.95 
                } 
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: @update
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    patch :update, id: @product, product: @update
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end

  # test of verification for image_url, must be like *.jpg\gif\png
  def new_product(image_url)
      Product.new(  title: " Jon's book",
                    description:  "book of Jons memory",
                    price: 45.3,
                    image_url: image_url)
  end

  test "image url" do
    #url images
    ok=%w{ fred.gif fred.jpg fred.png FRED.JPG  FRED.png
          http://a.b.c/x/y/z/fred.gif}
    bad=%w{ fred.doc fred.gif.more fred.gif/more}
    
    ok.each do |name|  
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end

    bad.each do |name| 
      assert new_product(name).invalid?, "{name} shouldn't be valid"
    end
  end
end

