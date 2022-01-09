defmodule BeesWeb.Public.Live.Components.Photo do
  @moduledoc false

  use BeesWeb, :component

  alias Bees.Schemas.Photo

  alias BeesWeb.Live.Components.Icons

  @spec main(%{photo: Photo.t(), socket: Phoenix.LiveView.Socket.t()}) ::
          Phoenix.LiveView.Rendered.t()
  def main(assigns) do
    div_class =
      case Map.get(assigns, :fixed_width, false) do
        true -> "w-full w-auto desktop:min-w-max desktop:w-auto"
        false -> "min-w-max w-auto"
      end

    img_class =
      case Map.get(assigns, :fixed_width, false) do
        true -> ""
        false -> "h-40"
      end

    ~H"""
    <div class={"px-2 mb-5 #{div_class}"}>
      <%= live_redirect to: Routes.gallery_index_path(@socket, :show, id: @photo.id) do %>
        <img 
          class={"desktop:h-72 desktop:w-auto bg-gray-100 flex-shrink-0 rounded object-cover #{img_class}"}
          src={@photo.image}
          role="button"
        />
      <% end %>
    </div>
    """
  end

  @spec modal(%{photo: Photo.t(), socket: Phoenix.LiveView.Socket.t()}) ::
          Phoenix.LiveView.Rendered.t()
  def modal(assigns) do
    ~H"""
    <div class={"fixed top-0 left-0 w-screen h-screen bg-black z-20 flex justify-center items-center p-20"}>
      <%= live_redirect to: Routes.gallery_index_path(@socket, :index) do %>
        <div class="text-white fixed top-5 right-5">
          <Icons.close />
        </div>
      <% end %>
      <img
        class="bg-white max-w-full max-h-full rounded object-scale-down" 
        src={@photo.image}
      /> 
    </div>
    """
  end
end
