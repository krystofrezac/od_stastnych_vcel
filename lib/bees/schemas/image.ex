defmodule Bees.Schemas.Image do
  @moduledoc false

  use Ecto.Schema
  use Waffle.Ecto.Schema

  import Ecto.Query

  alias __MODULE__
  alias Bees.Uploaders.ImageUploader

  @type t() :: %__MODULE__{
          id: integer(),
          file: String.t(),
          size: String.t()
        }
  schema "images" do
    field :file, ImageUploader.Type
    field :size, :string

    timestamps()
  end
end
