require 'test_helper'

class InviteMailerTest < ActionMailer::TestCase
  test 'invite' do
    invite = invites(:two)
    assert_equal 'please feel yourself invited', invite.letter
    email = InviteMailer.invite_mail(invite).deliver
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ['info@ist-ur.org'], email.from
    assert_equal ['jens@ist-ur.org'], email.to
    assert_equal 'that is no invitation', email.subject
  end
#   test 'the truth' do
#     assert true
#   end
end
