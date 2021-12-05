defmodule OdStastnychVcel.Schemas.Photo do
  @moduledoc false

  @enforce_keys [:id, :image, :home_page]
  defstruct [:id, :image, :home_page]
end
