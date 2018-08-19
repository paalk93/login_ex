defmodule LoginEx.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :adress, :string
      add :phone, :string
      add :login_id, references(:logins, on_delete: :delete_all)
      timestamps()
    end

    create index(:users, [:login_id])
  end
end
