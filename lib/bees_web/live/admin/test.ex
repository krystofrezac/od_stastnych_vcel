defmodule BeesWeb.Admin.Live.Test do
  use BeesWeb, [:live_view, :admin]

  import Ecto.Changeset

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:changeset, change())}
  end

  defp change(params\\%{}) do
    types = %{name: :string}

    {%{}, types}
    |> cast(params, Map.keys(types))
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div>
      <.modal_with_animations action="edit" changeset={@changeset}/>
      <.modal_with_animations action="add" changeset={@changeset}/>
    </div>
    """
  end

  defp modal_with_animations(assigns) do
    ~H"""
    <div id={@action} class="bg-red-100 p-4 m-2">
      <.form 
        let={f} 
        for={@changeset}  
        as={@action}
        phx-submit="submit" 
        phx-change="change"
      >
       <%= text_input f, :name %>   
      </.form>
    </div>
    """
  end
end
