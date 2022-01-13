defmodule BeesWeb.Admin.LayoutView.Flash do
  @moduledoc false

  use BeesWeb, :component

  alias Phoenix.LiveView.JS

  alias BeesWeb.Live.Components.Icons

  @spec info(%{flash: any()}) :: Phoenix.LiveView.Rendered.t()
  def info(assigns) do
    ~H"""
    <.main type={:info} {assigns}>
      <:icon>
        <Icons.info class="mr-2"/>
      </:icon>
    </.main>
    """
  end

  @spec error(%{flash: any()}) :: Phoenix.LiveView.Rendered.t()
  def error(assigns) do
    ~H"""
    <.main type={:error} {assigns}>
      <:icon>
        <Icons.ban class="mr-2"/>
      </:icon>
    </.main>
    """
  end

  defp main(assigns) do
    ~H"""
    <%= if live_flash(@flash, @type) do %>
      <div
        id={"alert-close-hook-#{@type}"}
        phx-hook="exec_js_after"
        after="5000"
        after-js={close(@type)}
      />
      <div 
        id={"alert-#{@type}"} 
        class={"alert alert-#{@type} mt-4 transition-all h-16 h-0 p-0 m-0 mt-0"} 
        role="alert" 
        phx-hook="on_mount_exec_js" 
        on-mount-js={open(@type)}
      >
        <div id={"alert-content-#{@type}"} class="transition-all flex-1 items-center opacity-0">
          <%= render_slot @icon %>
          <label>
            <%= live_flash(@flash, @type) %>
          </label>
          <button class="btn btn-sm btn-square btn-ghost ml-auto flex items-center justify-center" phx-click={close(@type)}>
            <Icons.close />
          </button>
        </div>
      </div>
    <% end %>
    """
  end

  defp close(type) do
    JS.remove_class("opacity-100", to: "#alert-content-#{type}", transition: "_")
    |> JS.add_class("h-0 p-0 m-0 mt-0", to: ".alert-#{type}", transition: "_", time: 150)
    |> JS.add_class("hidden", to: ".alert-#{type}", transition: "_", time: 300)
    |> JS.push("close_flash", value: %{type: type})
  end

  defp open(type) do
    JS.remove_class("h-0 p-0 m-0 mt-0", to: "#alert-#{type}")
    |> JS.add_class("opacity-100", to: "#alert-content-#{type}", transition: "_", time: 150)
  end
end
