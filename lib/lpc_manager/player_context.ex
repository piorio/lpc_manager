defmodule LpcManager.PlayerContext do
  @moduledoc """
  The PlayerContext context.
  """

  import Ecto.Query, warn: false
  alias LpcManager.Repo

  alias LpcManager.PlayerContext.RosterPlayer
  alias LpcManager.PlayerContext.Skill
  alias LpcManager.PlayerContext.Trait
  alias LpcManager.TeamContext

  @doc """
  Returns the list of roster_players.

  ## Examples

      iex> list_roster_players()
      [%RosterPlayer{}, ...]

  """
  def list_roster_players do
    Repo.all(RosterPlayer)
  end

  @doc """
  Gets a single roster_player.

  Raises `Ecto.NoResultsError` if the Roster player does not exist.

  ## Examples

      iex> get_roster_player!(123)
      %RosterPlayer{}

      iex> get_roster_player!(456)
      ** (Ecto.NoResultsError)

  """
  def get_roster_player!(id), do: Repo.get!(RosterPlayer, id)

  def get_roster_player_with_assoc!(id) do
    Repo.get!(RosterPlayer, id)
    |> Repo.preload(:traits)
    |> Repo.preload(:skills)
    |> Repo.preload(:roster_teams)
  end

  @doc """
  Creates a roster_player.

  ## Examples

      iex> create_roster_player(%{field: value})
      {:ok, %RosterPlayer{}}

      iex> create_roster_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_roster_player(attrs \\ %{}) do
    skills = list_skills(attrs["skills_ids"])
    traits = list_traits(attrs["traits_ids"])
    team = TeamContext.get_roster_team!(attrs["roster_team_id"])

    player =
      %RosterPlayer{}
      |> RosterPlayer.changeset(attrs)
      |> Ecto.Changeset.put_assoc(:skills, skills)
      |> Ecto.Changeset.put_assoc(:traits, traits)
      |> Ecto.Changeset.put_assoc(:roster_teams, team)
      |> Repo.insert()

    player
  end

  @doc """
  Updates a roster_player.

  ## Examples

      iex> update_roster_player(roster_player, %{field: new_value})
      {:ok, %RosterPlayer{}}

      iex> update_roster_player(roster_player, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_roster_player(%RosterPlayer{} = roster_player, attrs) do
    skills = list_skills(attrs["skills_ids"])
    traits = list_traits(attrs["traits_ids"])

    # Required to verify that team exist
    team = TeamContext.get_roster_team!(attrs["roster_team_id"])
    roster_player = %RosterPlayer{roster_player | roster_teams_id: attrs["roster_team_id"]}

    roster_player
    |> Repo.preload(:traits)
    |> Repo.preload(:skills)
    |> Repo.preload(:roster_teams)
    |> RosterPlayer.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:skills, skills)
    |> Ecto.Changeset.put_assoc(:traits, traits)
    |> Ecto.Changeset.put_assoc(:roster_teams, team)
    |> Repo.update()
  end

  @doc """
  Deletes a roster_player.

  ## Examples

      iex> delete_roster_player(roster_player)
      {:ok, %RosterPlayer{}}

      iex> delete_roster_player(roster_player)
      {:error, %Ecto.Changeset{}}

  """
  def delete_roster_player(%RosterPlayer{} = roster_player) do
    Repo.delete(roster_player)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking roster_player changes.

  ## Examples

      iex> change_roster_player(roster_player)
      %Ecto.Changeset{data: %RosterPlayer{}}

  """
  def change_roster_player(%RosterPlayer{} = roster_player, attrs \\ %{}) do
    RosterPlayer.changeset(roster_player, attrs)
  end

  @doc """
  Returns the list of skills.

  ## Examples

      iex> list_skills()
      [%Skill{}, ...]

  """
  def list_skills do
    Repo.all(Skill)
  end

  @doc """
  Returns the list of skills based on the list of skills id passed.
  If passed id is nil, an empty list will return

  ## Examples

      iex> list_skills([1])
      [%Skill{}, ...]
  """
  def list_skills(skill_ids) do
    if skill_ids do
      skills_query = from(s in Skill, where: s.id in ^skill_ids)
      LpcManager.Repo.all(skills_query)
    else
      []
    end
  end

  @doc """
  Gets a single skill.

  Raises `Ecto.NoResultsError` if the Skill does not exist.

  ## Examples

      iex> get_skill!(123)
      %Skill{}

      iex> get_skill!(456)
      ** (Ecto.NoResultsError)

  """
  def get_skill!(id), do: Repo.get!(Skill, id)

  @doc """
  Creates a skill.

  ## Examples

      iex> create_skill(%{field: value})
      {:ok, %Skill{}}

      iex> create_skill(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_skill(attrs \\ %{}) do
    %Skill{}
    |> Skill.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a skill.

  ## Examples

      iex> update_skill(skill, %{field: new_value})
      {:ok, %Skill{}}

      iex> update_skill(skill, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_skill(%Skill{} = skill, attrs) do
    skill
    |> Skill.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a skill.

  ## Examples

      iex> delete_skill(skill)
      {:ok, %Skill{}}

      iex> delete_skill(skill)
      {:error, %Ecto.Changeset{}}

  """
  def delete_skill(%Skill{} = skill) do
    Repo.delete(skill)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking skill changes.

  ## Examples

      iex> change_skill(skill)
      %Ecto.Changeset{data: %Skill{}}

  """
  def change_skill(%Skill{} = skill, attrs \\ %{}) do
    Skill.changeset(skill, attrs)
  end

  @doc """
  Returns the list of traits.

  ## Examples

      iex> list_traits()
      [%Trait{}, ...]

  """
  def list_traits do
    Repo.all(Trait)
  end

  def list_traits(trait_ids) do
    IO.puts("List traits with")
    IO.inspect(trait_ids)

    if trait_ids do
      traits_query = from(t in LpcManager.PlayerContext.Trait, where: t.id in ^trait_ids)
      LpcManager.Repo.all(traits_query)
    else
      []
    end
  end

  @doc """
  Gets a single trait.

  Raises `Ecto.NoResultsError` if the Trait does not exist.

  ## Examples

      iex> get_trait!(123)
      %Trait{}

      iex> get_trait!(456)
      ** (Ecto.NoResultsError)

  """
  def get_trait!(id), do: Repo.get!(Trait, id)

  @doc """
  Creates a trait.

  ## Examples

      iex> create_trait(%{field: value})
      {:ok, %Trait{}}

      iex> create_trait(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_trait(attrs \\ %{}) do
    %Trait{}
    |> Trait.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a trait.

  ## Examples

      iex> update_trait(trait, %{field: new_value})
      {:ok, %Trait{}}

      iex> update_trait(trait, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_trait(%Trait{} = trait, attrs) do
    trait
    |> Trait.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a trait.

  ## Examples

      iex> delete_trait(trait)
      {:ok, %Trait{}}

      iex> delete_trait(trait)
      {:error, %Ecto.Changeset{}}

  """
  def delete_trait(%Trait{} = trait) do
    Repo.delete(trait)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking trait changes.

  ## Examples

      iex> change_trait(trait)
      %Ecto.Changeset{data: %Trait{}}

  """
  def change_trait(%Trait{} = trait, attrs \\ %{}) do
    Trait.changeset(trait, attrs)
  end

  alias LpcManager.PlayerContext.Player

  @doc """
  Returns the list of players.

  ## Examples

      iex> list_players()
      [%Player{}, ...]

  """
  def list_players do
    Repo.all(Player)
  end

  @doc """
  Gets a single player.

  Raises `Ecto.NoResultsError` if the Player does not exist.

  ## Examples

      iex> get_player!(123)
      %Player{}

      iex> get_player!(456)
      ** (Ecto.NoResultsError)

  """
  def get_player!(id), do: Repo.get!(Player, id)

  @doc """
  Creates a player.

  ## Examples

      iex> create_player(%{field: value})
      {:ok, %Player{}}

      iex> create_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player.

  ## Examples

      iex> update_player(player, %{field: new_value})
      {:ok, %Player{}}

      iex> update_player(player, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_player(%Player{} = player, attrs) do
    player
    |> Player.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a player.

  ## Examples

      iex> delete_player(player)
      {:ok, %Player{}}

      iex> delete_player(player)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player(%Player{} = player) do
    Repo.delete(player)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player changes.

  ## Examples

      iex> change_player(player)
      %Ecto.Changeset{data: %Player{}}

  """
  def change_player(%Player{} = player, attrs \\ %{}) do
    Player.changeset(player, attrs)
  end
end
