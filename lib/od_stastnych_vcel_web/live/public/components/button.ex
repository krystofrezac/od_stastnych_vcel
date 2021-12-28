defmodule OdStastnychVcelWeb.Public.Live.Components.Button do
  @moduledoc false

  use Phoenix.Component

  @spec main(%{inner_block: any()}) :: Phoenix.LiveView.Rendered.t()
  def main(assigns) do
    class = get_classes(assigns)

    ~H"""
    <button class={class}>
      <%= render_slot(@inner_block) %>
    </button>
    """
  end

  defp get_classes(assigns) do
    class! = ["p-2 rounded"]

    class! =
      case Map.get(assigns, :color) do
        :honey -> ["bg-honey" | class!]
        _other -> ["bg-white" | class!]
      end

    class! =
      case Map.get(assigns, :size) do
        :large -> ["text-2xl" | class!]
        _other -> class!
      end

    class!
  end
end
