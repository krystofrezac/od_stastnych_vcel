defmodule OdStastnychVcel.Schemas.Product do
  @enforce_keys [:id, :name, :image, :description, :home_page]
  defstruct [:id, :name, :image, :description, :home_page]
end
