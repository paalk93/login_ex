defmodule LoginEx.Accounts.Login do
  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Pbkdf2
  alias LoginEx.Accounts.Login
  alias LoginEx.Accounts.User

  schema "logins" do
    field :encrypted_password, :string
    field :username, :string
    field :is_admin, :boolean, default: false
    has_one :user, LoginEx.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(login, attrs \\ %{}) do
    login
    |> cast(attrs, [:username, :encrypted_password, :is_admin])
    |> cast_assoc(:user)
    |> unique_constraint(:username)
    |> validate_required([:username, :encrypted_password])
    |> update_change(:encrypted_password, &Pbkdf2.hashpwsalt/1)
  end
end
