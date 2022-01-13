defmodule Bees.Products do
  @moduledoc false
  import Ecto.Changeset
  import Ecto.Query

  alias Bees.Repo
  alias Bees.Schemas.Product
  alias Bees.Schemas.Image

  @type product_data :: %{
          optional(:name) => String.t(),
          optional(:description) => String.t(),
          optional(:images) => list(Image.t()),
          optional(:order) => integer(),
          optional(:home_page) => boolean()
        }
  @spec list_products :: list(Product.t())
  def list_products do
    Product.sort_by_order()
    |> Product.sort_by_id()
    |> Product.preload_images()
    |> Repo.all()
  end

  @spec get_product(integer()) :: Product.t() | nil
  def get_product(id) do
    Product.preload_images()
    |> Repo.get(id)
  end

  @spec list_products_for_home_page() :: list(Product.t())
  def list_products_for_home_page do
    Product.where_home_page(true)
    |> Product.sort_by_order()
    |> Product.sort_by_id()
    |> Product.preload_images()
    |> Repo.all()
  end

  @spec add_product(product_data) :: {:ok, Product.t()} | {:error, Ecto.Changeset.t()}
  def add_product(product) do
    %Product{}
    |> cast(product, [:name, :description, :order, :home_page])
    |> put_assoc(:images, product.images)
    |> Repo.insert()
  end

  @spec update_product(Product.t(), product_data) ::
          {:ok, Product.t()} | {:error, Ecto.Changeset.t()}
  def update_product(%Product{} = product, changes) do
    product
    |> cast(changes, [:name, :description, :order, :home_page])
    |> put_assoc(:images, changes.images)
    |> Repo.update()
    |> IO.inspect()
  end

  @spec delete_product(Product.t()) :: {:ok, Product.t()} | {:error, Ecto.Changeset.t()}
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  def delete_image(%Image{} = image) do
    query =
      from i in "products_images",
        where: i.image_id == ^image.id

    Repo.delete_all(query)
  end
end
