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

  describe "users" do
    alias Bsc.Medical.User

    @valid_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name", password_hash: "some password_hash", reset_token: "some reset_token", role: "some role", username: "some username"}
    @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", password_hash: "some updated password_hash", reset_token: "some updated reset_token", role: "some updated role", username: "some updated username"}
    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, password_hash: nil, reset_token: nil, role: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Medical.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Medical.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Medical.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Medical.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.password_hash == "some password_hash"
      assert user.reset_token == "some reset_token"
      assert user.role == "some role"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Medical.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Medical.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.password_hash == "some updated password_hash"
      assert user.reset_token == "some updated reset_token"
      assert user.role == "some updated role"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Medical.update_user(user, @invalid_attrs)
      assert user == Medical.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Medical.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Medical.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Medical.change_user(user)
    end
  end

  describe "rooms" do
    alias Bsc.Medical.Room

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def room_fixture(attrs \\ %{}) do
      {:ok, room} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Medical.create_room()

      room
    end

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Medical.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Medical.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      assert {:ok, %Room{} = room} = Medical.create_room(@valid_attrs)
      assert room.description == "some description"
      assert room.name == "some name"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Medical.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      assert {:ok, room} = Medical.update_room(room, @update_attrs)
      assert %Room{} = room
      assert room.description == "some updated description"
      assert room.name == "some updated name"
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Medical.update_room(room, @invalid_attrs)
      assert room == Medical.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Medical.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Medical.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Medical.change_room(room)
    end
  end
end
