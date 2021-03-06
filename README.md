<!-- @format -->

[![hex.pm version](https://img.shields.io/hexpm/v/mixin.svg)](https://hex.pm/packages/mixin)
[![CI](https://github.com/tashirosota/mixin/actions/workflows/ci.yml/badge.svg)](https://github.com/tashirosota/mixin/actions/workflows/ci.yml)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/tashirosota/mixin)

# Mixin

Mixin for Elixir.
Delegates all functions to ModuleA from moduleB.
Works like a so-called `Mixin`.

## Installation

```elixir
def deps do
  [
    {:mixin, "~> 0.1.0"}
  ]
end
```

## Usage

```elixir
iex> defmodele ForDocFoo do
...>   def foo, do: :foo
...> end

iex> defmodele ForDocBar do
...>   require Mixin
...>   Mixin.include ForDocFoo
...> end

iex> ForDocBar.foo
:foo
```

## How is it better than import/2?

**When import/2.**

```elixir
iex> defmodule A do
...>   def a do
...>     :a
...>   end
...> end

iex> defmodule B do
...>   import A
...> end

iex> B.a()
** (UndefinedFunctionError) function B.a/0 is undefined or private
```

** When Mixin.include. **

```elixir
iex> defmodule A do
...>   def a do
...>     :a
...>   end
...> end

iex> defmodule B do
...>   require Mixin
...>   Mixin.include A
...> end

iex> B.a()
:a
```
