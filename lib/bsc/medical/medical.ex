defmodule Bsc.Medical do
  @moduledoc """
  The boundary for the Medical system.
  """

  import Ecto.Query, warn: false
  alias Bsc.Repo

  alias Bsc.Medical.Org

  @doc """
  Returns the list of orgs.

  ## Examples

      iex> list_orgs()
      [%Org{}, ...]

  """
  def list_orgs do
    Repo.all(Org)
  end

  @doc """
  Gets a single org.

  Raises `Ecto.NoResultsError` if the Org does not exist.

  ## Examples

      iex> get_org!(123)
      %Org{}

      iex> get_org!(456)
      ** (Ecto.NoResultsError)

  """
  def get_org!(id), do: Repo.get!(Org, id)

  @doc """
  Creates a org.

  ## Examples

      iex> create_org(%{field: value})
      {:ok, %Org{}}

      iex> create_org(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_org(attrs \\ %{}) do
    %Org{}
    |> Org.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a org.

  ## Examples

      iex> update_org(org, %{field: new_value})
      {:ok, %Org{}}

      iex> update_org(org, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_org(%Org{} = org, attrs) do
    org
    |> Org.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Org.

  ## Examples

      iex> delete_org(org)
      {:ok, %Org{}}

      iex> delete_org(org)
      {:error, %Ecto.Changeset{}}

  """
  def delete_org(%Org{} = org) do
    Repo.delete(org)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking org changes.

  ## Examples

      iex> change_org(org)
      %Ecto.Changeset{source: %Org{}}

  """
  def change_org(%Org{} = org) do
    Org.changeset(org, %{})
  end

  alias Bsc.Medical.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
