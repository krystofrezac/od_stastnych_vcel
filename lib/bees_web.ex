# credo:disable-for-this-file Credo.Check.Refactor.ModuleDependencies

defmodule BeesWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use BeesWeb, :controller
      use BeesWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  @spec controller() :: any()
  def controller do
    quote do
      use Phoenix.Controller, namespace: BeesWeb.Public

      import Plug.Conn
      import BeesWeb.Gettext
      # credo:disable-for-next-line Credo.Check.Readability.AliasAs
      alias BeesWeb.Router.Helpers, as: Routes
    end
  end

  @spec controller_admin() :: any()
  def controller_admin do
    quote do
      use Phoenix.Controller, namespace: BeesWeb.Admin

      import Plug.Conn
      import BeesWeb.Gettext
      # credo:disable-for-next-line Credo.Check.Readability.AliasAs
      alias BeesWeb.Router.Helpers, as: Routes
    end
  end

  @spec view() :: any()
  def view do
    quote do
      use Phoenix.View,
        root: "lib/bees_web/templates/public",
        namespace: BeesWeb.Public

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  @spec view_admin() :: any()
  def view_admin do
    quote do
      use Phoenix.View,
        root: "lib/bees_web/templates/admin",
        namespace: BeesWeb.Admin

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  @spec live_view() :: any()
  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {BeesWeb.Public.LayoutView, "live.html"}

      unquote(view_helpers())
    end
  end

  @spec live_view_admin() :: any()
  def live_view_admin do
    quote do
      use Phoenix.LiveView,
        layout: {BeesWeb.Admin.LayoutView, "live.html"}

      unquote(view_helpers())
    end
  end

  @spec live_component() :: any()
  def live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(view_helpers())
    end
  end

  @spec component() :: any()
  def component do
    quote do
      use Phoenix.Component

      unquote(view_helpers())
    end
  end

  @spec router() :: any()
  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  @spec channel() :: any()
  def channel do
    quote do
      use Phoenix.Channel
      import BeesWeb.Gettext
    end
  end

  @spec view_helpers() :: any()
  defp view_helpers do
    quote do
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      # Import LiveView and .heex helpers (live_render, live_patch, <.form>, etc)
      import Phoenix.LiveView.Helpers

      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import BeesWeb.ErrorHelpers
      import BeesWeb.Gettext
      # credo:disable-for-next-line Credo.Check.Readability.AliasAs
      alias BeesWeb.Router.Helpers, as: Routes
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  defmacro __using__(which) when is_list(which) do
    apply(__MODULE__, String.to_existing_atom(Enum.join(which, "_")), [])
  end
end
