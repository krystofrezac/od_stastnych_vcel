defmodule Bees.Repo.Migrations.CreateImageTable do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :file, :string, null: false
      add :size, :string 

      timestamps()
    end

    create table(:products_images) do
      add :product_id, references(:products)
      add :image_id, references(:images)
    end

    create unique_index(:products_images, [:product_id, :image_id])

    alter table(:products) do
      remove :image
    end
  end
end
