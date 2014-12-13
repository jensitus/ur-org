require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: 'Example', email: 'user@example.net', password: 'foobar', password_confirmation: 'foobar')
  end

  test 'should be valid' do
    puts @user.inspect
    assert @user.valid?
  end

  # test 'associated microposts should be destroyed' do
  #   @user.save
  #   @user.microposts.create!(content: "Lorem ipsum")
  #   assert_difference 'Micropost.count', -1 do
  #       @user.destroy
  #   end
  # end

end
