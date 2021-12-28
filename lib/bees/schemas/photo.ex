defmodule Bees.Schemas.Photo do
  @moduledoc false

  @enforce_keys [:id, :image, :home_page]
  defstruct [:id, :image, :home_page]

  @type t() :: %__MODULE__{
          id: integer(),
          image: String.t(),
          home_page: boolean()
        }
end
