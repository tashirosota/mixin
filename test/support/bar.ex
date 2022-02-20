defmodule Bar do
  require Mixin

  Mixin.include(Foo, except: [:undelegate_foo])

  def bar do
    :bar
  end
end
