defmodule LoginEx.Repo.Migrations.CreateLogins do
  use Ecto.Migration

  def change do
    create table(:logins) do
      add :username, :string
      add :encrypted_password, :string
      add :is_admin, :boolean, default: false, null: false
      timestamps()
    end

    create unique_index(:logins, [:username])
  end
end
