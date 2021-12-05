defmodule OdStastnychVcelWeb.Live.Components.Photo do
  @moduledoc false

  use OdStastnychVcelWeb, :component

  alias OdStastnychVcel.Schemas.Photo

  alias OdStastnychVcelWeb.Live.Components.Icons

  @spec main(%{photo: Photo.t(), socket: Phoenix.LiveView.Socket.t()}) ::
          Phoenix.LiveView.Rendered.t()
  def main(assigns) do
    ~H"""
    <div class="px-2 mb-5 min-w-max">
      <%= live_redirect to: Routes.gallery_index_path(@socket, :show, id: @photo.id) do %>
        <img 
          class={"h-40 desktop:h-72 desktop:w-auto bg-gray-100 flex-shrink-0 rounded object-cover"}
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
