defmodule OdStastnychVcelWeb.Live.Components.Photo do
  use OdStastnychVcelWeb, :component

  def main(assigns) do
    props = Map.get(assigns, :props, %{})

    ~H"""
    <img 
      class="w-72 desktop:h-72 desktop:w-auto bg-gray-100 flex-shrink-0 mx-2 mb-5 rounded object-cover"
      src={@photo.image}
      phx-value-id={@photo.id}
      {props} 
    />
    """
  end

  def modal(assigns) do
    open = Map.get(assigns, :open, false)

    image_props = Map.get(assigns, :image_props, %{})

    image =
      case assigns.photo do
        nil -> ""
        photo -> photo.image
      end

    ~H"""
    <div class={"#{!open&&"hidden"} fixed top-0 left-0 w-screen h-screen bg-black z-10 flex justify-center items-center p-20"}>
      <img
        class="bg-white max-w-full max-h-full rounded object-scale-down" 
        src={image}
        {image_props}
      /> 
    </div>
    """
  end
end
