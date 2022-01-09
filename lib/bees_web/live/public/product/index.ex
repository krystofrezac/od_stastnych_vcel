defmodule BeesWeb.Public.Live.Product.Index do
  @moduledoc false

  use BeesWeb, :live_view

  import Ecto.Changeset

  alias Bees.Products

  alias BeesWeb.Public.Live.Components.Product
  alias BeesWeb.Public.Live.Components.Wave

  @impl Phoenix.LiveView
  def mount(params, _session, socket) do
    types = %{id: :integer}

    %{id: id} =
      {%{}, types}
      |> cast(params, Map.keys(types))
      |> apply_action!(:validate)

    {
      :ok,
      assign(socket, :product, Products.get_product(id))
    }
  end
end
