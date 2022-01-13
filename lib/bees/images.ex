defmodule Bees.Images do
  use Waffle.Ecto.Schema

  alias Bees.Repo
  alias Bees.Schemas.Image
  alias Bees.Uploaders.ImageUploader

  @spec add_image(String.t()) :: {:ok, Image.t()} | {:error, Ecto.Changeset.t()}
  def add_image(path) do
    %Image{}
    |> cast_attachments(%{file: path}, [:file], allow_paths: true)
    |> Repo.insert()
  end

  def delete_file(%Image{} = image) do
    :ok =
      ImageUploader.url(image.file.file_name)
      |> ImageUploader.delete()
  end

  def accepted_formats do
    ImageUploader.accepted_formats()
  end

  def url(%Image{} = image) do
    ImageUploader.url(image.file.file_name)
  end
end
