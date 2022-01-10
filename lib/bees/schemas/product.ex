defmodule Bees.Schemas.Product do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Query

  alias __MODULE__

  @type t() :: %__MODULE__{
          id: integer(),
          name: String.t(),
          description: String.t(),
          image: String.t(),
          order: integer(),
          home_page: boolean()
        }
  schema "products" do
    field :name, :string
    field :description, :string
    field :image, :string
    field :order, :integer
    field :home_page, :boolean

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

  defp query_start do
    from p in Product, as: :products
  end
end
