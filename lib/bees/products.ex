defmodule Bees.Products do
  @moduledoc false
  import Ecto.Changeset

  alias Bees.Repo
  alias Bees.Schemas.Product

  @type product_data :: %{
          optional(:name) => String.t(),
          optional(:description) => String.t(),
          optional(:image) => String.t(),
          optional(:order) => integer(),
          optional(:home_page) => boolean()
        }

  @spec list_products :: list(Product.t())
  def list_products do
    Product.sort_by_order()
    |> Product.sort_by_id()
    |> Repo.all()
  end

  @spec get_product(integer()) :: Product.t() | nil
  def get_product(id) do
    Repo.get(Product, id)
  end

  @spec list_products_for_home_page() :: list(Product.t())
  def list_products_for_home_page do
    Product.where_home_page(true)
    |> Product.sort_by_order()
    |> Product.sort_by_id()
    |> Repo.all()
  end

  @spec add_product(product_data) :: {:ok, Product.t()} | {:error, Ecto.Changeset.t()}
  def add_product(product) do
    %Product{}
    |> change(product)
    |> Repo.insert()
  end

  @spec update_product(Product.t(), product_data) ::
          {:ok, Product.t()} | {:error, Ecto.Changeset.t()}
  def update_product(%Product{} = product, changes) do
    product
    |> change(changes)
    |> Repo.update()
  end

  @spec delete_product(Product.t()) :: {:ok, Product.t()} | {:error, Ecto.Changeset.t()}
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end
end
