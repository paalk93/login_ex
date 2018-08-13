defmodule LoginEx.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Pbkdf2
  alias LoginEx.Accounts.User


  schema "users" do
    field :encrypted_password, :string
    field :username, :string
    field :is_admin, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :encrypted_password, :is_admin])
    |> unique_constraint(:username)
    |> validate_required([:username, :encrypted_password])
    |> update_change(:encrypted_password, &Pbkdf2.hashpwsalt/1)
  end
end
