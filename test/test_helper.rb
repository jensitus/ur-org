ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

#require 'minitest/rails'
require 'minitest/reporters'

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # Log in a test user
  def log_in_as(user, options = {})
    password = options[:password] || 'password'
    remember_me = options[:remember_me] || '1'
    if integration_test?
      post user_session_path, session: { email: user.email,
                                  password: password,
                                  remember_me: remember_me }
    else
      session[:user_id] = user.id
    end
  end

  private

  def integration_test?
    defined?(post_via_redirect)
  end

end

class ActionController::TestCase
  include Devise::TestHelpers
end

class Mock < Struct
  module DefaultAttribute
    attr_reader :defaults
  end

  def self.new(defaults)
    attributes = defaults.keys
    klass = super(*attributes)
    klass.extend DefaultAttribute
    klass.instance_variable_set :@defaults, defaults
    klass.include Constructor
    klass
  end

  module Constructor
    def initialize(attrs = {})
      attrs = self.class.defaults.merge(attrs)
      super()
      attrs.each do |key, value|
        self.send "#{key}=", value
      end
    end
  end
end
