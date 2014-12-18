require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase
  test "confirmation" do
    mail = ContactMailer.confirmation
    assert_equal "Confirmation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "inquiry" do
    mail = ContactMailer.inquiry
    assert_equal "Inquiry", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
