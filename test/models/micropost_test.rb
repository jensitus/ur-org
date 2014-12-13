require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:two)
    @micropost = @user.microposts.build(content: 'Lorem ipsum')
    # puts @micropost.inspect
  end

  test 'should be valid' do
    assert @micropost.valid?
  end

  test 'user id should be present' do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test 'content should be present ' do
    @micropost.content = "        "
    assert_not @micropost.valid?
  end

  test 'content should be at most 140 characters' do
    @micropost.content = "a" * 140
    assert @micropost.valid?
  end

  test 'order should be most recent first' do
    assert_equal Micropost.first, microposts(:most_recent)
    puts Micropost.first.inspect
    puts microposts(:most_recent).inspect
  end

end
