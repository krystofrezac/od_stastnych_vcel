defmodule OdStastnychVcel.Schemas.Product do
  @enforce_keys [:id, :name, :image, :description]
  defstruct [:id, :name, :image, :description]
end
