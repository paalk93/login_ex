# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LoginEx.Repo.insert!(%LoginEx.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

{:ok, _user} = LoginEx.Accounts.create_user(%{
  username: "admin1",
  encrypted_password: "pwadmin1",
  is_admin: true
})

{:ok, _user} = LoginEx.Accounts.create_user(%{
  username: "user1",
  encrypted_password: "pwuser1",
  is_admin: false
})

{:ok, _user} = LoginEx.Accounts.create_user(%{
  username: "user2",
  encrypted_password: "pwuser2",
  is_admin: false
})
