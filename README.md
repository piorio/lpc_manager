# LpcManager

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix


mix phx.gen.html RosterPlayerContext RosterPlayer roster_players min_quantity:integer max_quantity:integer position:string cost:integer movement_allowance:integer strength:integer agility:integer passing:integer armour_valuev:integer primary:array:string secondary:array:string

mix phx.gen.schema LpcManagerWeb.RosterPlayerSkill roster_players_skills roster_player_id:references:roster_players skill_id:references:skills
mix phx.gen.schema LpcManagerWeb.RosterPlayerTrait roster_players_traits roster_player_id:references:roster_players trait_id:references:traits
