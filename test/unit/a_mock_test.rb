require_relative '../test_helper'

class AMockTest < ActiveSupport::TestCase
  SomeMock = Mock.new(foo: "foo_default", bar: nil) 

  test "sets mock class' defaults" do
    assert_equal({ foo: "foo_default", bar: nil }, SomeMock.defaults)
  end

  test "SomeMock is a class" do
    assert_kind_of(Class, SomeMock)
  end

  test "Inherits setters" do
    sm = SomeMock.new(foo: "fooish", bar: "barish")
    assert_equal("fooish", sm.foo)
    assert_equal("barish", sm.bar)
  end

  test "Inherits getters" do
    sm = SomeMock.new
    assert_nil(sm.bar)
  end

  test "sets defaults in mock object" do
    sm = SomeMock.new
    assert_equal("foo_default", sm.foo)
  end
end
