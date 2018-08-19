defmodule LoginEx.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias LoginEx.Accounts
  alias LoginEx.Accounts.Login
  alias LoginEx.Accounts.User

  schema "users" do
    field :name, :string
    field :adress, :string
    field :phone, :string
    belongs_to :login, LoginEx.Accounts.Login
    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :adress, :phone])
    |> validate_required([:name, :adress, :phone])
  end
end
