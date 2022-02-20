defmodule Foo do
  require Mixin

  Mixin.included do
    require Logger

    def log_info(text) do
      Logger.info(text)
    end

    def sum(x, y) do
      x + y
    end
  end

  def foo do
    :foo
  end

  def undelegate_foo do
    :undelegate_foo
  end
end
