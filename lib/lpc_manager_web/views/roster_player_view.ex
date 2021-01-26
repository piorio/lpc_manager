defmodule LpcManagerWeb.RosterPlayerView do
  use LpcManagerWeb, :view

  def skills_input(form, skills, changeset_skills) do
    selected_skills = changeset_skills
    |> Enum.map(fn s -> s.id end)

    IO.inspect(selected_skills)

    multiple_select(form, :skills_ids, skills, selected: selected_skills, class: "form-control form-control-lg")
  end

  def traits_input(form, traits, changeset_traits) do
    selected_traits = changeset_traits
    |> Enum.map(fn t -> t.id end)

    multiple_select(form, :traits_ids, traits, selected: selected_traits, class: "form-control form-control-lg")
  end
end
