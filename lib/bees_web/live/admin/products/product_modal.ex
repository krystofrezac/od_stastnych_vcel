defmodule BeesWeb.Admin.Live.Products.ProductModal do
  @moduledoc false

  use BeesWeb, :live_component

  alias BeesWeb.Admin.Live.Components.Form
  alias BeesWeb.Admin.Live.Components.Modal

  @spec main(%{action: String.t(), text: String.t(), changeset: Ecto.Changeset.t()}) ::
          Phoenix.LiveView.Rendered.t()
  def main(assigns) do
    on_close = "close_#{assigns.action}_product"

    # If inline generates inputs twice
    as = "#{assigns.action}_product"

    ~H"""
    <Modal.main 
      id={@action}
      open={@open}
      on_close={on_close}
    >
      <:title>
        <%= @text %>
      </:title>
      <.form 
        let={f} 
        for={@changeset}  
        as={as}
        phx-submit={"#{@action}_product_submit"} 
        phx-change={"#{@action}_product_change"}
      >
        <Form.text_input
          form={f}
          field={:name}
          label="Název"
        />

        <Form.textarea
          form={f}
          field={:description}
          label="Popis"
        />

        <Form.text_input
          form={f}
          field={:image}
          label="Obrazek"
        />

        <Form.number_input
          form={f}
          field={:order}
          label="Pořadí (kolikáty se bude produkt zobrazovat v seznamu)"
        />

        <Form.checkbox
          form={f}
          field={:home_page}
          label="Bude se zobrazovat na hlavní stránce"
        />
        
        <Modal.actions>
          <button 
            type="button"
            class="btn"
            phx-click={on_close}
          >
            Zrušit
          </button>
          <Form.submit>
            <%= @text %>
          </Form.submit>
        </Modal.actions>
      </.form>
    </Modal.main>
    """
  end
end
