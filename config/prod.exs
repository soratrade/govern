import Config

config :govern, GovernWeb.Endpoint,
  # url: [host: "govern.herokuapp.com", port: 443],
  url: [scheme: "https", host: "govern.herokuapp.com", port: 443], force_ssl: [rewrite_on: [:x_forwarded_proto]], 
  cache_static_manifest: "priv/static/cache_manifest.json"

# Do not print debug messages in production
config :logger, level: :info
