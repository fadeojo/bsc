# Latest version of Erlang-based Elixir installation: https://hub.docker.com/_/elixir/
FROM elixir:1.5.2

# Create and set home directory
ENV HOME /opt/bsc
WORKDIR $HOME

ENV TRANSLOADIT_KEY 9e08a8f0377011e4a504f7d600a22694
ENV TRANSLOADIT_SECRET c113d70b914ff7bd9e31ed8070108510617de695
ENV TRANSLOADIT_TEMPLATE_ID c2a108510a6fa11e78ae8394c1aaa5aef

ENV AWS_ACCESS_KEY_ID AKIAJKURJUL22GSPJWMQ
ENV AWS_SECRET_ACCESS_KEY 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
ENV SECRET_KEY_BASE yKF3glWJyzZrY5IFLlMCFxnJDBhqEEap8zMk0+GjLO7LknLZ0DZ72jiqSaZvsFQY

# Configure required environment
ENV MIX_ENV prod

# Set and expose PORT environmental variable
EXPOSE 4000
EXPOSE 5432

# Install hex (Elixir package manager)
RUN mix local.hex --force

# Install rebar (Erlang build tool)
RUN mix local.rebar --force

# Copy all application files
COPY . .
RUN rm -rf ./_build
RUN rm -rf ./.elixir_ls
RUN rm -rf ./.vscode
RUN rm -rf ./deps

# Copy all dependencies files
COPY mix.* ./

# Install all production dependencies
RUN mix deps.get --only prod

# Compile all dependencies
RUN mix deps.compile

# Compile the entire project
RUN mix compile

# Run Ecto migrations and Phoenix server as an initial command
CMD mix do ecto.migrate, phx.server