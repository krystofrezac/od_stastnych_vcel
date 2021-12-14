defmodule OdStastnychVcelWeb.Live.Product.Index do
  @moduledoc false

  use OdStastnychVcelWeb, :live_view

  import Ecto.Changeset

  alias OdStastnychVcel.Products

  alias OdStastnychVcelWeb.Live.Components.Product
  alias OdStastnychVcelWeb.Live.Components.Wave

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
