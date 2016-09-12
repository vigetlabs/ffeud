# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :family_feud,
  ecto_repos: [FamilyFeud.Repo]

# Configures the endpoint
config :family_feud, FamilyFeud.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WcEYEVpYC8LtISeDt2/UHZypcyqr0txTyYMrQPHjwnoYUmpvJuPKXf74zkBRCthT",
  render_errors: [view: FamilyFeud.ErrorView, accepts: ~w(html json)],
  pubsub: [name: FamilyFeud.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
