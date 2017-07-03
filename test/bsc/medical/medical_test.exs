defmodule Bsc.MedicalTest do
  use Bsc.DataCase

  alias Bsc.Medical

  describe "orgs" do
    alias Bsc.Medical.Org

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def org_fixture(attrs \\ %{}) do
      {:ok, org} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Medical.create_org()

      org
    end

    test "list_orgs/0 returns all orgs" do
      org = org_fixture()
      assert Medical.list_orgs() == [org]
    end

    test "get_org!/1 returns the org with given id" do
      org = org_fixture()
      assert Medical.get_org!(org.id) == org
    end

    test "create_org/1 with valid data creates a org" do
      assert {:ok, %Org{} = org} = Medical.create_org(@valid_attrs)
      assert org.name == "some name"
    end

    test "create_org/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Medical.create_org(@invalid_attrs)
    end

    test "update_org/2 with valid data updates the org" do
      org = org_fixture()
      assert {:ok, org} = Medical.update_org(org, @update_attrs)
      assert %Org{} = org
      assert org.name == "some updated name"
    end

    test "update_org/2 with invalid data returns error changeset" do
      org = org_fixture()
      assert {:error, %Ecto.Changeset{}} = Medical.update_org(org, @invalid_attrs)
      assert org == Medical.get_org!(org.id)
    end

    test "delete_org/1 deletes the org" do
      org = org_fixture()
      assert {:ok, %Org{}} = Medical.delete_org(org)
      assert_raise Ecto.NoResultsError, fn -> Medical.get_org!(org.id) end
    end

    test "change_org/1 returns a org changeset" do
      org = org_fixture()
      assert %Ecto.Changeset{} = Medical.change_org(org)
    end
  end
end
