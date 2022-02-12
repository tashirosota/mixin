defmodule MixinTest do
  use ExUnit.Case
  doctest Mixin

  test "test" do
    assert Bar.foo() == Foo.foo()

    assert_raise UndefinedFunctionError, fn ->
      Bar.undelegate_foo()
    end
  end
end
