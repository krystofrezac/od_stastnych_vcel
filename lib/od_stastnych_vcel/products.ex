defmodule OdStastnychVcel.Products do
  alias OdStastnychVcel.Schemas.Product

  def list_products do
    [
      %Product{id: 0, name: "a", image: "images/i1.png", description: "ahoj"},
      %Product{id: 0, name: "Domaci med", image: "images/i1.png", description: "ahoj"},
      %Product{id: 0, name: "Domaci med", image: "images/i1.png", description: "ahoj"},
      %Product{id: 0, name: "Domaci med", image: "images/i1.png", description: "ahoj"},
      %Product{id: 0, name: "Domaci med", image: "images/i1.png", description: "ahoj"},
      %Product{id: 0, name: "Domaci med", image: "images/i1.png", description: "ahoj"},
      %Product{id: 0, name: "Domaci med", image: "images/i1.png", description: "ahoj"},
      %Product{id: 0, name: "Domaci med", image: "images/i1.png", description: "ahoj"},
      %Product{id: 0, name: "Domaci med", image: "images/i1.png", description: "ahoj"},
      %Product{id: 0, name: "Domaci med", image: "images/i1.png", description: "ahoj"},
      %Product{id: 0, name: "Domaci med", image: "images/i1.png", description: "ahoj"},
      %Product{id: 0, name: "Domaci med", image: "images/i1.png", description: "ahoj"},
      %Product{id: 1, name: "Domaci med", image: "images/i1.png", description: "hola"}
    ]
  end

  def get_product(id) do
    Enum.find(list_products(), fn product -> product.id == id end)
  end
end
