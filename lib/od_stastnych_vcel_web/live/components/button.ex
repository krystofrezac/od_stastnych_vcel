defmodule OdStastnychVcelWeb.Live.Components.Button do
  use Phoenix.Component

  def main(assigns) do
    class = getClasses(assigns)

    ~H"""
    <button class={class}>
      <%= render_slot(@inner_block) %>
    </button>
    """
  end

  defp getClasses(assigns) do
    class = ["p-2 rounded"]

    class =
      case Map.get(assigns, :color) do
        :honey -> ["bg-honey" | class]
        _ -> ["bg-white" | class]
      end

    class =
      case Map.get(assigns, :size) do
        :large -> ["text-2xl" | class]
        _ -> class
      end

    class
  end
end
