defmodule RealDealApi.AccountsTest do
  use RealDealApi.DataCase

  alias RealDealApi.Accounts
  alias RealDealApi.Accounts.Account

  import RealDealApi.AccountsFixtures

  describe "accounts" do

    @invalid_attrs %{email: nil, hash_password: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Accounts.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounts.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{email: "some.email@test.com", hash_password: "some#hash_password"}

      assert {:ok, %Account{} = account} = Accounts.create_account(valid_attrs)
      assert account.email == valid_attrs[:email]
      assert Bcrypt.verify_pass(valid_attrs[:hash_password], account.hash_password)
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      updated_attrs = %{email: "some.email.up@teste.com", hash_password: "some$updated$hash_password"}

      assert {:ok, %Account{} = account} = Accounts.update_account(account, updated_attrs)
      assert account.email == updated_attrs[:email]
      assert Bcrypt.verify_pass(updated_attrs[:hash_password], account.hash_password)
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_account(account, @invalid_attrs)
      assert account == Accounts.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Accounts.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Accounts.change_account(account)
    end
  end

  describe "get_account/1" do
    test "success: it returns an account when given a valid UUID" do
      existing_account = account_fixture()
      assert returned_account = Accounts.get_account!(existing_account.id)
      assert returned_account == existing_account
    end

    test "error: raises a Ecto.NoResultsError when an account doesm't exist" do
      assert_raise Ecto.NoResultsError, fn ->
        Accounts.get_account!(Ecto.UUID.autogenerate())
      end
    end
  end
end
