defmodule Wolk.AlbumsTest do
  use Wolk.DataCase

  alias Wolk.Albums

  describe "albums" do
    alias Wolk.Albums.Album

    import Wolk.AlbumsFixtures

    @invalid_attrs %{name: nil}

    test "list_albums/0 returns all albums" do
      album = album_fixture()
      assert Albums.list_albums() == [album]
    end

    test "get_album!/1 returns the album with given id" do
      album = album_fixture()
      assert Albums.get_album!(album.id) == album
    end

    test "create_album/1 with valid data creates a album" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Album{} = album} = Albums.create_album(valid_attrs)
      assert album.name == "some name"
    end

    test "create_album/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Albums.create_album(@invalid_attrs)
    end

    test "update_album/2 with valid data updates the album" do
      album = album_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Album{} = album} = Albums.update_album(album, update_attrs)
      assert album.name == "some updated name"
    end

    test "update_album/2 with invalid data returns error changeset" do
      album = album_fixture()
      assert {:error, %Ecto.Changeset{}} = Albums.update_album(album, @invalid_attrs)
      assert album == Albums.get_album!(album.id)
    end

    test "delete_album/1 deletes the album" do
      album = album_fixture()
      assert {:ok, %Album{}} = Albums.delete_album(album)
      assert_raise Ecto.NoResultsError, fn -> Albums.get_album!(album.id) end
    end

    test "change_album/1 returns a album changeset" do
      album = album_fixture()
      assert %Ecto.Changeset{} = Albums.change_album(album)
    end
  end

  describe "kiekje" do
    alias Wolk.Albums.Kiekje

    import Wolk.AlbumsFixtures

    @invalid_attrs %{name: nil}

    test "list_kiekje/0 returns all kiekje" do
      kiekje = kiekje_fixture()
      assert Albums.list_kiekje() == [kiekje]
    end

    test "get_kiekje!/1 returns the kiekje with given id" do
      kiekje = kiekje_fixture()
      assert Albums.get_kiekje!(kiekje.id) == kiekje
    end

    test "create_kiekje/1 with valid data creates a kiekje" do
      valid_attrs = %{name: "some name", image: "some image"}

      assert {:ok, %Kiekje{} = kiekje} = Albums.create_kiekje(valid_attrs)
      assert kiekje.name == "some name"
      assert kiekje.image == "some image"
    end

    test "create_kiekje/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Albums.create_kiekje(@invalid_attrs)
    end

    test "update_kiekje/2 with valid data updates the kiekje" do
      kiekje = kiekje_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Kiekje{} = kiekje} = Albums.update_kiekje(kiekje, update_attrs)
      assert kiekje.name == "some updated name"
    end

    test "update_kiekje/2 with invalid data returns error changeset" do
      kiekje = kiekje_fixture()
      assert {:error, %Ecto.Changeset{}} = Albums.update_kiekje(kiekje, @invalid_attrs)
      assert kiekje == Albums.get_kiekje!(kiekje.id)
    end

    test "delete_kiekje/1 deletes the kiekje" do
      kiekje = kiekje_fixture()
      assert {:ok, %Kiekje{}} = Albums.delete_kiekje(kiekje)
      assert_raise Ecto.NoResultsError, fn -> Albums.get_kiekje!(kiekje.id) end
    end

    test "change_kiekje/1 returns a kiekje changeset" do
      kiekje = kiekje_fixture()
      assert %Ecto.Changeset{} = Albums.change_kiekje(kiekje)
    end
  end
end
