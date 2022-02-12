defmodule Mixin.MixProject do
  use Mix.Project
  @version "0.1.0"
  @source_url "https://github.com/tashirosota/mixin"
  @description "Mixin for Elixir. Delegates all functions to ModuleA from moduleB."

  def project do
    [
      app: :mixin,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: @description,
      elixirc_paths: elixirc_paths(Mix.env()),
      name: "Mixin",
      package: package(),
      docs: docs(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package() do
    [
      licenses: ["Apache-2.0"],
      maintainers: ["Sota Tashiro"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end
end
