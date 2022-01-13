defmodule Bees.Schemas.Product do
  @moduledoc false

  use Ecto.Schema
  use Waffle.Ecto.Schema

  import Ecto.Query

  alias __MODULE__
  alias Bees.Schemas.Image

  @type t() :: %__MODULE__{
          id: integer(),
          name: String.t(),
          description: String.t(),
          images: list(Image.t()),
          order: integer(),
          home_page: boolean()
        }
  schema "products" do
    field :name, :string
    field :description, :string
    field :order, :integer
    field :home_page, :boolean
    many_to_many :images, Image, join_through: "products_images", on_replace: :delete

    timestamps()
  end

  @spec where_home_page(Ecto.Queryable.t(), boolean()) :: Ecto.Query.t()
  @spec where_home_page(boolean()) :: Ecto.Query.t()
  def where_home_page(query \\ query_start(), value) do
    from [products: p] in query,
      where: p.home_page == ^value
  end

  @spec sort_by_order(Ecto.Queryable.t()) :: Ecto.Query.t()
  @spec sort_by_order() :: Ecto.Query.t()
  def sort_by_order(query \\ query_start()) do
    from [products: p] in query,
      order_by: p.order
  end

  @spec sort_by_id(Ecto.Queryable.t()) :: Ecto.Query.t()
  @spec sort_by_id() :: Ecto.Query.t()
  def sort_by_id(query \\ query_start()) do
    from [products: p] in query,
      order_by: p.id
  end

  @spec preload_images(Ecto.Queryable.t()) :: Ecto.Query.t()
  @spec preload_images() :: Ecto.Query.t()
  def preload_images(query \\ query_start()) do
    from [products: p] in query,
      preload: [:images]
  end

  defp query_start do
    from p in Product, as: :products
  end
end
