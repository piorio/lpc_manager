defmodule LpcManager.Repo do
  use Ecto.Repo,
    otp_app: :lpc_manager,
    adapter: Ecto.Adapters.Postgres
end
