use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :ucx_ucc, UcxUccWeb.Endpoint,
  http: [port: 4017],
  https: [port: 4317,
    otp_app: :ucx_ucc,
    keyfile: "priv/key.pem",
    certfile: "priv/cert.pem"
  ],
  debug_errors: true,
  code_reloader: true,
  # code_reloader: false,
  check_origin: false,
  watchers: [node: ["node_modules/.bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../assets", __DIR__)]]

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# command from your terminal:
#
#     openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" -keyout priv/server.key -out priv/server.pem
#
# The `http:` config above can be replaced with:
#
#     https: [port: 4000, keyfile: "priv/server.key", certfile: "priv/server.pem"],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Watch static and templates for browser reloading.
config :ucx_ucc, UcxUccWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/ucx_ucc/web/views/.*(ex)$},
      ~r{lib/ucx_ucc/web/templates/.*(eex|haml|slim|slime)$},
      # ~r{plugins/.*/lib/.*/web/views/.*(ex)$},
      # ~r{plugins/.*/lib/.*/web/templates/.*(eex|haml|slim|slime)$},
    ]
  ]

config :ucx_ucc, :ucc_tracer_modules, :all
config :ucx_ucc, :ucc_tracer_level, :warn

# Do not include metadata nor timestamps in development logs
config :logger, :console,
  level: :info,
  # level: :error,
  format: "\n$time [$level]$levelpad$metadata$message\n",
  metadata: [:module, :function, :line]

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 30

# Finally import the config/dev.secret.exs
# which should be versioned separately.
if File.exists? "config/dev.secret.exs" do
  import_config "dev.secret.exs"
end

# defmodule GlobalState do
#   # Public API
#   def start(initial_state) do
#     spawn(fn -> loop(initial_state) end)
#   end
#   def append(pid, item) do
#     send pid, {:append, item}
#   end
#   def prepend(pid, item) do
#     send pid, {:prepend, item}
#   end
#   def get(pid) do
#     send pid, {:get, self()}
#     receive do
#       {:result, result} -> result
#     end
#   end
#   def stop(pid) do
#     send(pid, :stop)
#   end

#   # Private main loop
#   defp loop(state) do
#     receive do
#       {:prepend, item} ->
#         loop([item | state])
#       {:append, item} ->
#         loop(state ++ [item])
#       {:get, pid} ->
#         send pid, {:result, state}
#         loop(state)
#       :stop ->
#         IO.puts "I'm done"
#         :ok
#     end
#   end
# end

# pid = GlobalState.start [1,2,3]
# GlobalState.append pid, 4
# GlobalState.prepend pid, 0
# GlobalState.get pid
# GlobalState.stop pid
