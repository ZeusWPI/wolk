defmodule Wolk.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Wolk.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        admin: true,
        name: "some name"
      })
      |> Wolk.Accounts.create_user()

    user
  end
end
