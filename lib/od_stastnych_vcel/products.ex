defmodule OdStastnychVcel.Products do
  alias OdStastnychVcel.Schemas.Product

  def list_products do
    [
      %Product{id: 0, name: "Domaci med", image: "images/a.png"},
      %Product{id: 1, name: "Domaci med", image: "images/a.png"}
    ]
  end
end
