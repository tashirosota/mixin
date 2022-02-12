defmodule Mixin do
  @doc """
  Mixin for Elixir.
  Delegates functions to ModuleA from moduleB
  """
  @default_undelegate_functions [:__info__, :module_info, :"MACRO-__using__"]
  @moduledoc """
  Delegates functions.
  When dose not give opts, delegates all functions.
  ## opts
   - `except`: Excepts the functions to be delegated.
   - `only`: Selects the functions to be delegated.
  """
  @spec include(module(), except: [], only: []) :: list
  defmacro include(module, opts \\ []) do
    only = opts |> Keyword.get(:only)
    except = opts |> Keyword.get(:except)

    functions =
      elem(Code.eval_quoted(module), 0).module_info()[:exports]
      |> Enum.filter(fn {fun, _} ->
        fun not in @default_undelegate_functions
      end)

    funs =
      cond do
        only -> functions |> Enum.filter(fn {fun, _} -> fun in only end)
        except -> functions |> Enum.reject(fn {fun, _} -> fun in except end)
        true -> functions
      end

    for {fun, arity} <- funs do
      quote do
        defdelegate unquote(fun)(unquote_splicing(make_args(arity))), to: unquote(module)
      end
    end
  end

  defp make_args(0), do: []

  defp make_args(n) do
    Enum.map(1..n, fn n -> {String.to_atom("arg#{n}"), [], Elixir} end)
  end
end
