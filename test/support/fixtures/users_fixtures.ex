defmodule RealDealApi.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RealDealApi.Users` context.
  """
  @doc """
  Generate a user.
  """
  import RealDealApi.AccountsFixtures

  def user_fixture(attrs \\ %{}) do
    account = account_fixture(%{email: "some.random@email.com"})

    {:ok, user} =
      attrs
      |> Enum.into(%{
        biography: "some biography",
        full_name: "some full_name",
        gender: "some gender"
      })
      |> (&RealDealApi.Users.create_user(account, &1)).()

    user
  end
end
