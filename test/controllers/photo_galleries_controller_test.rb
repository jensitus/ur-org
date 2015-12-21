require 'test_helper'

class PhotoGalleriesControllerTest < ActionController::TestCase
  setup do
    @photo_gallery = photo_galleries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:photo_galleries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create photo_gallery" do
    assert_difference('PhotoGallery.count') do
      post :create, photo_in_gallery: { description: @photo_gallery.description, title: @photo_gallery.title }
    end

    assert_redirected_to photo_gallery_path(assigns(:photo_in_gallery))
  end

  test "should show photo_gallery" do
    get :show, id: @photo_gallery
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @photo_gallery
    assert_response :success
  end

  test "should update photo_gallery" do
    patch :update, id: @photo_gallery, photo_in_gallery: { description: @photo_gallery.description, title: @photo_gallery.title }
    assert_redirected_to photo_gallery_path(assigns(:photo_in_gallery))
  end

  test "should destroy photo_gallery" do
    assert_difference('PhotoGallery.count', -1) do
      delete :destroy, id: @photo_gallery
    end

    assert_redirected_to photo_galleries_path
  end
end
