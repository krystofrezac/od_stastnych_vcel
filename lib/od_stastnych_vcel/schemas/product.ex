defmodule OdStastnychVcel.Schemas.Product do
  @moduledoc false

  @enforce_keys [:id, :name, :image, :description, :home_page]
  defstruct [:id, :name, :image, :description, :home_page]

  @type t() :: %__MODULE__{
          id: integer(),
          name: String.t(),
          image: String.t(),
          description: String.t(),
          home_page: boolean()
        }
end
