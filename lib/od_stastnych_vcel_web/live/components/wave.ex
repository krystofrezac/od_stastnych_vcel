defmodule OdStastnychVcelWeb.Live.Components.Wave do
  use Phoenix.Component

  def main(assigns) do
    svg_class = ["relative -z-10"]

    svg_class =
      case(Map.get(assigns, :inverted)) do
        true -> ["transorrm rotate-180" | svg_class]
        _ -> svg_class
      end

    ~H"""
      <svg 
        class={svg_class} 
        viewBox="0 0 1440 100" 
        xmlns="http://www.w3.org/2000/svg"
      >
        <path 
          class="fill-current text-honey" 
          d={@d}
        />
      </svg>
    """
  end
end
