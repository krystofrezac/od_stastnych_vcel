defmodule BeesWeb.Admin.Live.Components.Form do
  @moduledoc false

  use BeesWeb, :component

  @type assigns :: %{form: Phoenix.HTML.Form, field: atom(), inner_block: any()}

  @spec submit(assigns()) :: Phoenix.LiveView.Rendered.t()
  def submit(assigns) do
    ~H"""
    <%= submit class: "btn btn-outline btn-accent" do %>
      <%= render_slot(@inner_block) %>
    <% end %>
    """
  end

  @spec text_input(assigns()) :: Phoenix.LiveView.Rendered.t()
  def text_input(assigns) do
    ~H"""
    <.input {assigns}>
      <%= text_input @form, @field, class: "input input-bordered" %>
    </.input>
    """
  end

  @spec password_input(assigns()) :: Phoenix.LiveView.Rendered.t()
  def password_input(assigns) do
    ~H"""
    <.input {assigns}>
      <%= password_input @form, @field, 
        value: input_value(@form, @field), 
        class: "input input-bordered" 
      %>
    </.input>
    """
  end

  @spec input(assigns()) :: Phoenix.LiveView.Rendered.t()
  def input(assigns) do
    ~H"""
    <div 
      class="form-control" 
      phx-hook="form-input" 
      id={@field} 
      input_name={@form.id<>"[#{@field}]"}
    >
      <label class="label">
        <span class="label-text">
          <%= @label %>
        </span>
      </label> 
      <%= render_slot(@inner_block) %>
      <label class={"label"}>
        <span class="label-text-alt h-3">
          <%= error_tag @form, @field %> 
        </span>
      </label>
    </div>
    """
  end
end
