defmodule LpcManagerWeb.RosterPlayerView do
  use LpcManagerWeb, :view

  def skills_input(form, skills) do
    multiple_select(form, :skills, skills, class: "form-control form-control-lg")
  end

  def traits_input(form, traits) do
    multiple_select(form, :traits, traits, class: "form-control form-control-lg")
  end
end
