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

## Purpose and use cases

It is common to use to divide the fat module into each context to improve readability.

Let me give you an example.
User Models are often bigger due to many functions and relationships due to their nature.

```elixir
# lib/model/user.ex
defmodule Model.User do
  use Model

  @type t :: %__MODULE__{}

  @default_password

  schema "users" do
    field :disabled, :boolean, default: false
    field :password_hash, :string
    field :email, :string
    has_one :profile, Model.Profile
    has_one :wallet, Model.Wallet
    has_many :articles, Model.Article
    # ..etc
    timestamps()
  end
end
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
