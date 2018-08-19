defmodule LoginEx.Accounts do


  import Ecto.Query, warn: false
  alias LoginEx.Repo

  alias LoginEx.Accounts.Login
  alias LoginEx.Accounts.User

  def get_by_username(username) when is_nil(username) do
    nil
  end

  def get_by_username(username) do
    Repo.get_by(Login, username: username)
  end

 # LOGINS
  def list_logins do
    Repo.all(Login)
    |> LoginEx.Repo.preload(:user)
  end

  def get_login!(id), do: Repo.get!(Login, id) |> LoginEx.Repo.preload(:user)

  def create_login(attrs \\ %{}) do
    %Login{}
    |> LoginEx.Repo.preload(:user)
    |> Login.changeset(attrs)
    |> Repo.insert()
  end

  def update_login(%Login{} = login, attrs) do
    login
    |> LoginEx.Repo.preload(:user)
    |> Login.changeset(attrs)
    |> Repo.update()
  end

  def delete_login(%Login{} = login) do
    Repo.delete(login)
    |> LoginEx.Repo.preload(:user)
  end

  def change_login(%Login{} = login) do
    Login.changeset(login, %{})
  end

# USERS
  def change_user(%User{} = user) do
    Login.changeset(user, %{})
  end

  def list_users do
    Repo.all(User)
    |> Repo.preload(:login)
  end

  def get_user!(id), do: Repo.get!(User, id) |> Repo.preload(:login)

  def create_user(attrs \\ %{}) do
    %User{}
    |> Repo.preload(:login)
    |> User.changeset(attrs)
    |> Repo.insert()
  end


end
