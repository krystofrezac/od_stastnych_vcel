defmodule BeesWeb.Admin.Live.Products.Index do
  @moduledoc false

  use BeesWeb, [:live_view, :admin]

  import Ecto.Changeset

  alias Bees.Products

  alias BeesWeb.Admin.Live.Components.Card
  alias BeesWeb.Admin.Live.Components.Modal
  alias BeesWeb.Admin.Live.Components.Table
  alias BeesWeb.Admin.Live.Components.Tooltip
  alias BeesWeb.Admin.Live.Products.ProductModal
  alias BeesWeb.Live.Components.Icons

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(:products, Products.list_products())
      |> assign(:add_changeset, normalize_product(%{}))
      |> assign(:edit_changeset, normalize_product(%{}))
      |> assign(:add_product, false)
      |> assign(:edit_product, nil)
      |> assign(:delete_product, nil)
    }
  end

  @impl Phoenix.LiveView
  def handle_event("add_product_change", %{"add_product" => params}, socket) do
    changeset =
      normalize_product(params)
      |> Map.put(:action, :change)

    {
      :noreply,
      socket
      |> assign(:add_changeset, changeset)
    }
  end

  @impl Phoenix.LiveView
  def handle_event("add_product_submit", %{"add_product" => params}, socket) do
    with {:ok, product_data} <- normalize_product(params) |> apply_action(:submit),
         {:ok, product} <- Products.add_product(product_data) do
      {
        :noreply,
        socket
        |> assign(:add_changeset, normalize_product(%{}))
        |> assign(:add_product, false)
        |> assign(:products, Products.list_products())
        |> put_flash(:info, "Produkt úspěšně přidán")
      }
    else
      {:error, changeset} ->
        {
          :noreply,
          socket
          |> assign(:add_changeset, changeset)
        }
    end
  end

  @impl Phoenix.LiveView
  def handle_event("edit_product_change", %{"edit_product" => params}, socket) do
    changeset =
      normalize_product(params)
      |> Map.put(:action, :change)

    {
      :noreply,
      socket
      |> assign(:edit_changeset, changeset)
    }
  end

  @impl Phoenix.LiveView
  def handle_event("edit_product_submit", %{"edit_product" => params}, socket) do
    with {:ok, product_data} <-
           normalize_product(params) |> apply_action(:submit),
         {:ok, product} <- Products.update_product(socket.assigns.edit_product, product_data) do
      {
        :noreply,
        socket
        |> assign(:edit_product, nil)
        |> assign(:products, Products.list_products())
        |> put_flash(:info, "Produkt úspěšně upraven")
      }
    else
      {:error, changeset} ->
        {
          :noreply,
          socket
          |> assign(:edit_changeset, changeset)
        }
    end
  end

  @impl Phoenix.LiveView
  def handle_event("open_add_product", _params, socket) do
    {
      :noreply,
      socket
      |> assign(:add_product, true)
    }
  end

  @impl Phoenix.LiveView
  def handle_event("close_add_product", _params, socket) do
    {
      :noreply,
      socket
      |> assign(:add_product, false)
    }
  end

  @impl Phoenix.LiveView
  def handle_event("open_edit_product", %{"product" => id}, socket) do
    product = Products.get_product(id)

    {
      :noreply,
      socket
      |> assign(:edit_changeset, normalize_product(product |> Map.from_struct()))
      |> assign(:edit_product, product)
    }
  end

  @impl Phoenix.LiveView
  def handle_event("close_edit_product", _params, socket) do
    {
      :noreply,
      socket
      |> assign(:edit_product, nil)
    }
  end

  @impl Phoenix.LiveView
  def handle_event("open_delete_product", %{"product" => product}, socket) do
    {
      :noreply,
      socket
      |> assign(:delete_product, product)
    }
  end

  @impl Phoenix.LiveView
  def handle_event("close_delete_product", _params, socket) do
    {
      :noreply,
      socket
      |> assign(:delete_product, nil)
    }
  end

  @impl Phoenix.LiveView
  def handle_event("submit_delete_product", _params, socket) do
    Products.get_product(socket.assigns.delete_product)
    |> Products.delete_product()

    {
      :noreply,
      socket
      |> assign(:products, Products.list_products())
      |> assign(:delete_product, nil)
      |> put_flash(:info, "Produkt úspěšně odstraněn")
    }
  end

  defp normalize_product(params) do
    types = %{
      name: :string,
      description: :string,
      image: :string,
      home_page: :boolean,
      order: :integer
    }

    {%{}, types}
    |> cast(params, Map.keys(types))
    |> validate_required(Map.keys(types))
  end
end
