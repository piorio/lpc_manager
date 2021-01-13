# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LpcManager.Repo.insert!(%LpcManager.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Add default Admin user
case LpcManager.Users.create_admin(%{
       email: "admin@example.com",
       password: "password",
       confirm_password: "password",
       password_hash: Pow.Ecto.Schema.Password.pbkdf2_hash("password"),
       role: "admin",
       coach_name: "admin"
     }) do
  {:ok, _user} ->
    IO.puts("Admin created successfully")

  {:error, error_data} ->
    IO.puts("Unable to create default admin user")
    IO.inspect(error_data)
end
