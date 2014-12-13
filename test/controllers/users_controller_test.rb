require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'create_account' do
    if User.create(email: 'jens@open-lab.org', password: 'himmelhilf')
      assert true
    else
      assert User.msq
    end
  end

  test "should get login" do
    get :sign_in
    assert_response :success
  end

end