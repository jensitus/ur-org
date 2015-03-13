require 'test_helper'

class MentionMailerTest < ActionMailer::TestCase
  test "comment_mention" do
    mail = MentionMailer.comment_mention
    assert_equal "Comment mention", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "micropost_mention" do
    mail = MentionMailer.micropost_mention
    assert_equal "Micropost mention", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
