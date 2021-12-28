defmodule OdStastnychVcelWeb.Public.Live.Components.Wave do
  @moduledoc false

  use Phoenix.Component

  @spec main(%{assigns: %{d: String.t(), inverted: boolean(), on_top: boolean(), white: boolean}}) ::
          Phoenix.LiveView.Rendered.t()
  def main(assigns) do
    svg_class! = ["relative -z-10 -mt-px"]
    path_class! = ["fill-current"]

    svg_class! =
      case(Map.get(assigns, :inverted)) do
        true -> ["transorrm rotate-180" | svg_class!]
        _other -> svg_class!
      end

    svg_class! =
      case(Map.get(assigns, :on_top)) do
        true -> ["z-10" | svg_class!]
        _other -> ["z-0" | svg_class!]
      end

    path_class! =
      case(Map.get(assigns, :white)) do
        true -> ["text-white" | path_class!]
        _other -> ["text-honey" | path_class!]
      end

    ~H"""
      <svg 
        class={svg_class!} 
        viewBox="0 0 1440 100" 
        xmlns="http://www.w3.org/2000/svg"
      >
        <path 
          class={path_class!}
          d={@d}
        />
      </svg>
    """
  end
end
