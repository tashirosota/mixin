defmodule Mixin do
  @moduledoc """
  Mixin for Elixir.
  Delegates functions to ModuleA from moduleB
  """
  @default_undelegate_functions [:__info__, :module_info, :"MACRO-__using__"]
  @doc """
  Delegates functions.
  When no option is given, delegates all functions.
  ## opts
   - `except`: Excepts the functions to be delegated.
   - `only`: Selects the functions to be delegated.
  """
  @spec include(module(), except: [], only: []) :: list
  defmacro include(module, opts \\ []) do
    only = opts |> Keyword.get(:only)
    except = opts |> Keyword.get(:except)
    module = elem(Code.eval_quoted(module), 0)
    ast = module.__included_block__() |> Code.string_to_quoted!()

    for {fun, arity} <- functions(module, only, except) do
      quote do
        defdelegate unquote(fun)(unquote_splicing(make_args(arity))), to: unquote(module)
      end
    end ++
      [
        quote do
          Code.eval_quoted(unquote(ast), binding(), __ENV__)
        end
      ]
  end

  @doc """
  The value of do block is evaluated when __MODULE__ is Mixin.included.
  It’s like __using__ for Mixin only.

  """
  defmacro included(do: block) do
    quote do
      @__included_block__ unquote(block |> inspect())
      def __included_block__, do: @__included_block__
    end
  end

  defp functions(module, only, except) do
    funs =
      module.module_info()[:exports]
      |> Enum.filter(fn {fun, _} ->
        fun not in @default_undelegate_functions
      end)

    cond do
      only -> funs |> Enum.filter(fn {fun, _} -> fun in only end)
      except -> funs |> Enum.reject(fn {fun, _} -> fun in except end)
      true -> funs
    end
  end

  defp make_args(0), do: []

  defp make_args(n) do
    Enum.map(1..n, fn n -> {String.to_atom("arg#{n}"), [], Elixir} end)
  end
end
