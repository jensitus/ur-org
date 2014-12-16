require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: 'Example', email: 'user@example.net', password: 'foobar', password_confirmation: 'foobar')
  end

#  test 'should be valid' do
#    puts @user.inspect
#    assert @user.valid?
#  end

  test 'should follow and unfollow a user' do
    jens = users(:jens)
    emil = users(:emil)
    assert_not jens.following?(emil)
    jens.follow(emil)
    assert jens.following?(emil)
    assert emil.followers.include?(jens)
    jens.unfollow(emil)
    assert_not jens.following?(emil)
  end

  test 'feed should have the right posts' do
    jens = users(:jens)
    emil = users(:emil)
    # Posts from followed user:
    jens.microposts.each do |post_following|
      assert emil.feed.include?(post_following)
    end
    # posts from self
    emil.microposts.each do |post_self|
      assert emil.feed.inlcude?(post_self)
    end

  end

  # test 'associated microposts should be destroyed' do
  #   @user.save
  #   @user.microposts.create!(content: "Lorem ipsum")
  #   assert_difference 'Micropost.count', -1 do
  #       @user.destroy
  #   end
  # end

end
