defmodule BeesWeb.Admin.Live.Products.ProductModal do
  @moduledoc false

  use BeesWeb, :component

  alias Bees.Images

  alias BeesWeb.Admin.Live.Components.Form
  alias BeesWeb.Admin.Live.Components.Modal
  alias BeesWeb.Live.Components.Icons

  @spec main(%{
          optional(:product) => Bees.Schemas.Product.t(),
          action: String.t(),
          text: String.t(),
          changeset: Ecto.Changeset.t(),
          deleted_images: list(integer())
        }) ::
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

        <section phx-drop-target={@uploads.image.ref}>
          <%= live_file_input @uploads.image %>

          <%= if Map.has_key?(assigns, :product) && @product do %>
            <div class="flex overflow-x-auto">
              <%= for image <- @product.images do %>
                <% IO.inspect(@deleted_images) %>
                <%= if !(image.id in @deleted_images) do%>
                  <div class="relative w-max">
                    <img class="h-28 max-w-none" src={Images.url(image)}>
                    <div class="h-full w-full absolute top-0 left-0 group">
                      <div class="h-full w-full opacity-0 group-hover:opacity-70 transition-opacity bg-black absolute top-0 left-0"/>
                      <div 
                        class="opacity-0 group-hover:opacity-100 transition-opacity absolute top-2 left-2 cursor-pointer" 
                        phx-value-id={image.id} 
                        phx-click="delete_image"
                      >
                        <Icons.close color="white"/>
                      </div>
                    </div>
                  </div>
                <% end %>
              <% end %>
            </div>
          <% end %>

          <%= for entry <- @uploads.image.entries do %>
            <figure>
              <%= live_img_preview entry %>
              <figcaption><%= entry.client_name %></figcaption>
            </figure>
            <div class="flex items-center">
              <progress class="progress progress-primary mr-4" value={entry.progress} max="100"> <%= entry.progress %>% </progress>
              <button phx-click="cancel-upload" phx-value-ref={entry.ref} aria-label="cancel">&times;</button>
            <div>
            <%= for err <- upload_errors(@uploads.image, entry) do %>
              <div class="alert alert-error my-2">
                <label><%= image_error_to_string(err) %></label>
              </div>
            <% end %>
          <% end %>
        </section>
        
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

  def image_error_to_string(:too_large), do: "Soubor je moc velký"
  def image_error_to_string(:too_many_files), do: "Vybrali jste moc souborů"
  def image_error_to_string(:not_accepted), do: "Vybrali jste špatný soubor souboru"
end
