require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @user = users(:jens)
    @other_user = users(:emil)
  end

  test 'should redirect following when not logged in' do
    get :following, id: @user
    assert_redirected_to new_user_session_path
  end

  test 'should redirect followers when not logged in' do
    get :followers, id: @user
    assert_redirected_to new_user_session_path
  end

  # test 'create_account' do
  #   if User.create(email: 'jens@open-lab.org', password: 'himmelhilf')
  #     assert true
  #   else
  #     assert User.msq
  #   end
  # end
  #
  # test "should get login" do
  #   get :sign_in
  #   assert_response :success
  # end

end