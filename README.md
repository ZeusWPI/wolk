# Wolk

## Setup

Make sure the following tools are installed:
- asdf (with the [elixir](https://github.com/asdf-vm/asdf-elixir), [erlang](https://github.com/asdf-vm/asdf-erlang) & [pnpm](https://github.com/jonathanmorley/asdf-pnpm) plugins)
- docker


- Run `asdf install`
- Start the services in the docker compose file or your postgres & minio servers
- Run `mix setup` to install all the dependencies
- Run `mix phx.server` to start you development server

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).
