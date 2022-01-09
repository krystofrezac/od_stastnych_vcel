defmodule Bees.Repo.Migrations.AddUserName do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :name, :string, null: false, default: "-"
    end
  end
end
