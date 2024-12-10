defmodule WolkWeb.KiekjeControllerTest do
  use WolkWeb.ConnCase

  import Wolk.AlbumsFixtures

  alias Wolk.Albums.Kiekje

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all kiekje", %{conn: conn} do
      conn = get(conn, ~p"/api/kiekje")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create kiekje" do
    test "renders kiekje when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/kiekje", kiekje: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/kiekje/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/kiekje", kiekje: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update kiekje" do
    setup [:create_kiekje]

    test "renders kiekje when data is valid", %{conn: conn, kiekje: %Kiekje{id: id} = kiekje} do
      conn = put(conn, ~p"/api/kiekje/#{kiekje}", kiekje: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/kiekje/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, kiekje: kiekje} do
      conn = put(conn, ~p"/api/kiekje/#{kiekje}", kiekje: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete kiekje" do
    setup [:create_kiekje]

    test "deletes chosen kiekje", %{conn: conn, kiekje: kiekje} do
      conn = delete(conn, ~p"/api/kiekje/#{kiekje}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/kiekje/#{kiekje}")
      end
    end
  end

  defp create_kiekje(_) do
    kiekje = kiekje_fixture()
    %{kiekje: kiekje}
  end
end
