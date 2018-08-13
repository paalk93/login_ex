# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :login_ex,
  ecto_repos: [LoginEx.Repo]

# Configures the endpoint
config :login_ex, LoginExWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mzPTGynAqoo2RPyub4bUnNWL8IRfRV+KhhGz+zq+mmUtg2H3e0oQ3kZkjwkov4Ff",
  render_errors: [view: LoginExWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LoginEx.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
