defmodule Bees.Repo.Migrations.AddProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string, null: false
      add :description, :text, null: false
      add :image, :string, null: false
      add :order, :integer, null: false
      add :home_page, :boolean, null: false

      timestamps()
    end

    create index(:products, [:home_page])
  end
end
