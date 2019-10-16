defmodule SocialMediaSnapshot.MixProject do
  use Mix.Project

  def project do
    [
      app: :social_media_snapshot,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :ueberauth, :ueberauth_facebook],
      mod: {SocialMediaSnapshot.Application, [env: Mix.env()]}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mix_test_watch, "~> 0.9.0", only: :test, runtime: false},
      {:commanded, git: "https://github.com/commanded/commanded.git"},
      {:jason, "~> 1.1"},
      {:ueberauth, "~> 0.6"},
      {:plug_cowboy, "~> 2.0"},
      {:ueberauth_facebook, "~> 0.8"},
      {:poison, "~> 4.0"},
      {:httpoison, "~> 1.5"},
      {:commanded_extreme_adapter,
       git: "https://github.com/commanded/commanded-extreme-adapter.git"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:commanded_ecto_projections, "~> 0.8",
       git: "https://github.com/commanded/commanded-ecto-projections.git"},
      {:bypass, "~> 1.0", only: :test}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib", "priv"]

  defp aliases do
    [
      # test: "test --no-start",
      # "test.watch": "test.watch --no-start"
    ]
  end
end
