defmodule Wolk.KiekjeImage do
  use Waffle.Definition
  use Waffle.Ecto.Definition

  # To add a thumbnail version:
  @versions [:original, :thumb]

  def acl(_, _), do: :public_read

  # Override the bucket on a per definition basis:
  def bucket do
    :wolk
  end

  # def bucket({_file, scope}) do
  #   scope.bucket || bucket()
  # end

  # Whitelist file extensions:
  def validate({file, _}) do
    file_extension = file.file_name |> Path.extname() |> String.downcase()

    case Enum.member?(~w(.jpg .jpeg .png .webp), file_extension) do
      true -> :ok
      false -> {:error, "invalid file type"}
    end
  end

  # Define a thumbnail transformation:
  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format png", :png}
  end

  # Override the persisted filenames:
  def filename(version, {file, _scope}) do
    "#{version}_#{file.file_name |> Path.basename() |> Path.rootname()}"
  end

  # Override the storage directory:
  def storage_dir(_version, {_file, scope}) do
    "kiekjes/#{scope.id}"
  end

  # Provide a default URL if there hasn't been a file uploaded
  # def default_url(version, scope) do
  #   "/images/avatars/default_#{version}.png"
  # end

  # Specify custom headers for s3 objects
  # Available options are [:cache_control, :content_disposition,
  #    :content_encoding, :content_length, :content_type,
  #    :expect, :expires, :storage_class, :website_redirect_location]

  def s3_object_headers(_version, {file, _scope}) do
    [content_type: MIME.from_path(file.file_name)]
  end
end
