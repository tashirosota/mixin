defmodule MixinTest do
  use ExUnit.Case
  doctest Mixin

  test "test" do
    assert Bar.foo() == Foo.foo()
    assert 3 = Bar.sum(1, 2)

    assert_raise UndefinedFunctionError, fn ->
      Bar.undelegate_foo()
    end
  end
end
