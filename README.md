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

attrs = %{"agility" => "1", "armour_value" => "1", "cost" => "11", "max_quantity" => "1", "min_quantity" => "1", "movement_allowance" => "1", "passing" => "1", "position" => "Lineman1", "primary" => ["AGILITY", "GENERAL", "MUTATIONS"], "secondary" => ["PASSING", "STRENGTH"], "skills" => ["1"], "strength" => "1", "traits" => ["1"]}
LpcManager.RosterPlayerContext.create_roster_player(attrs)
  LpcManager.SkillRules.create_skill(%{"name" => "name", "category" => "AGILITY"})
  LpcManager.TraitRules.create_trait(%{"name" => "name"})
user = Repo.get(RosterPlayer, 1)|> Repo.preload(:skills)|>Repo.preload(:traits)

TEAM

team_attrs = %{"apothecary" => "false", "name" => "name", "re_roll_cost" => "2", "re_roll_max" => "7", "special_rules" => "asd", "tier" => "2", "race_id" => "1"}
roster_team = %LpcManager.RosterTeamContext.RosterTeam{} |> LpcManager.RosterTeamContext.RosterTeam.changeset(team_attrs) |> Repo.insert
team = Repo.get(LpcManager.RosterTeamContext.RosterTeam, 1)

assoc 
user = Repo.get(RosterPlayer, 1) |> Repo.preload(:roster_teams)
changeset = user |> Changeset.change() |> Changeset.put_assoc(:roster_teams, team)

TEAM UI
<span><%= link "Edit", to: Routes.team_path(@conn, :edit, team) %></span>
<span><%= link "Delete", to: Routes.team_path(@conn, :delete, team), method: :delete, data: [confirm: "Are you sure?"] %></span>
<span><%= link "Edit", to: Routes.team_path(@conn, :edit, @team) %></span>




mix phx.gen.html PlayerContext Player players hiring_fee:integer current_value:integer movement_allowance:integer strength:integer agility:integer passing:integer armour_value:integer name:string number:integer roster_player_id:references:roster_players team_id:references:teams unspent_spp:integer total_spp:integer