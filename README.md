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


rmap = %{min_quantity: 5, max_quantity: 5, position: "Lineman", cost: 10, movement_allowance: 3, strength: 2, agility: 2, passing: 3, armour_value: 2, primary: ["1"], secondary: ["1"]}
LpcManager.RosterPlayerContext.create_roster_player(rmap)

  Parameters: %{"_csrf_token" => "UikbaAgqBQ08EAsEVTQaJlsQHlAHKnhQ7ypXYBN9NhgTbvOjcsI5FrI6", "roster_player" => %{"agility" => "1", "armour_value" => "1", "cost" => "11", "max_quantity" => "1", "min_quantity" => "1", "movement_allowance" => "1", "passing" => "1", "position" => "Lineman1", "primary" => ["AGILITY", "GENERAL", "MUTATIONS"], "secondary" => ["PASSING", "STRENGTH"], "skills" => ["1"], "strength" => "1", "traits" => ["1"]}}
