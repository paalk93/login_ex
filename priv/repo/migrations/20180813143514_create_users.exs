defmodule LoginEx.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :encrypted_password, :string
      add :is_admin, :boolean, default: false, null: false
      timestamps()
    end

    create unique_index(:users, [:username])
  end
end
