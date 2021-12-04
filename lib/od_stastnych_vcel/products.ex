defmodule OdStastnychVcel.Products do
  alias OdStastnychVcel.Schemas.Product

  def list_products do
    [
      %Product{id: 0, name: "a", image: "images/i1.png", description: "ahoj", home_page: true},
      %Product{
        id: 1,
        name: "Domaci med",
        image: "images/i1.png",
        description: "ahoj",
        home_page: true
      },
      %Product{
        id: 2,
        name: "Domaci med",
        image: "images/i1.png",
        description: "ahoj",
        home_page: true
      },
      %Product{
        id: 3,
        name: "Domaci med",
        image: "images/i1.png",
        description: "ahoj",
        home_page: true
      },
      %Product{
        id: 4,
        name: "Domaci med",
        image: "images/i1.png",
        description: "ahoj",
        home_page: true
      },
      %Product{
        id: 5,
        name: "Domaci med",
        image: "images/i1.png",
        description: "ahoj",
        home_page: true
      },
      %Product{
        id: 6,
        name: "Domaci med",
        image: "images/i1.png",
        description: "ahoj",
        home_page: false
      },
      %Product{
        id: 7,
        name: "Domaci med",
        image: "images/i1.png",
        description: "ahoj",
        home_page: false
      },
      %Product{
        id: 8,
        name: "Domaci med",
        image: "images/i1.png",
        description: "ahoj",
        home_page: false
      },
      %Product{
        id: 9,
        name: "Domaci med",
        image: "images/i1.png",
        description: "ahoj",
        home_page: false
      },
      %Product{
        id: 10,
        name: "Domaci med",
        image: "images/i1.png",
        description: "ahoj",
        home_page: false
      },
      %Product{
        id: 11,
        name: "Domaci med",
        image: "images/i1.png",
        description: "ahoj",
        home_page: false
      },
      %Product{
        id: 12,
        name: "Domaci med",
        image: "images/i1.png",
        description: "hola",
        home_page: false
      }
    ]
  end

  def get_product(id) do
    Enum.find(list_products(), fn product -> product.id == id end)
  end

  def list_products_for_home_page() do
    Enum.filter(list_products(), fn product -> product.home_page end)
  end
end
