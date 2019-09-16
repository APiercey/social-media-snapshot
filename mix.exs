defmodule SocialMediaSnapshot.MixProject do
  use Mix.Project

  def project do
    [
      app: :social_media_snapshot,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :ueberauth, :ueberauth_facebook],
      mod: {SocialMediaSnapshot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mix_test_watch, "~> 0.9.0"},
      # {:commanded, "~> 0.19"},
      {:jason, "~> 1.1"},
      {:ueberauth, "~> 0.6"},
      {:plug_cowboy, "~> 2.0"},
      {:ueberauth_facebook, "~> 0.8"}
    ]
  end
end
