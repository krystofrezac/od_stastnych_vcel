defmodule OdStastnychVcelWeb.Live.Product.Index do
  use OdStastnychVcelWeb, :live_view

  import Ecto.Changeset

  alias OdStastnychVcel.Products

  alias OdStastnychVcelWeb.Live.Components.Wave
  alias OdStastnychVcelWeb.Live.Components.Product

  @impl true
  def mount(params, _session, socket) do
    types = %{id: :integer}

    %{id: id} =
      {%{}, types}
      |> cast(params, Map.keys(types))
      |> apply_action!(:validate)

    {
      :ok,
      socket
      |> assign(:product, Products.get_product(id))
    }
  end
end
