defmodule OdStastnychVcel.Gallery do
  alias OdStastnychVcel.Schemas.Photo

  def list_photos do
    [
      %Photo{id: 0, image: "images/p1.jpg"},
      %Photo{id: 1, image: "images/p2.jpg"},
      %Photo{id: 2, image: "images/p3.jpg"},
      %Photo{id: 3, image: "images/p4.jpg"},
      %Photo{id: 4, image: "images/p5.jpg"},
      %Photo{id: 5, image: "images/p6.jpg"},
      %Photo{id: 6, image: "images/p7.jpg"},
      %Photo{id: 7, image: "images/p8.jpg"},
      %Photo{id: 8, image: "images/p20.jpg"},
      %Photo{id: 9, image: "images/p9.jpg"},
      %Photo{id: 10, image: "images/p10.jpg"},
      %Photo{id: 11, image: "images/p11.jpg"},
      %Photo{id: 12, image: "images/p12.jpg"},
      %Photo{id: 13, image: "images/p13.jpg"},
      %Photo{id: 14, image: "images/p14.jpg"},
      %Photo{id: 15, image: "images/p15.jpg"},
      %Photo{id: 16, image: "images/p16.jpg"},
      %Photo{id: 17, image: "images/p17.jpg"},
      %Photo{id: 18, image: "images/p18.jpg"},
      %Photo{id: 19, image: "images/p19.jpg"},
    ]
  end

  def get_photo(id) do
    Enum.find(list_photos(), fn photo -> photo.id == id end)
  end
end
