defmodule LoginExWeb.UserController do
  use LoginExWeb, :controller
  alias LoginEx.Accounts
  alias LoginEx.Accounts.User
  alias LoginExWeb.Helpers.Auth


plug :check_auth when action in [:my_profile]

defp check_auth(conn, _args) do
  if user_id = get_session(conn, :current_user_id) do
  current_user = Accounts.get_user!(user_id)
  conn
    |> assign(:current_user, current_user)
  else
    conn
    |> put_flash(:error, "You need to be signed in to access this page.")
    |> redirect(to: page_path(conn, :index))
    |> halt()
  end
end

plug :check_admin_auth when action in [:index]

defp check_admin_auth(conn, _args) do
  if user_id = get_session(conn, :current_user_id) do
  current_user = Accounts.get_user!(user_id)
  if current_user.is_admin == true do
  conn
    |> assign(:current_user, current_user)
  else
    conn
    |> put_flash(:error, "Access denied.")
    |> redirect(to: page_path(conn, :index))
    |> halt()
  end  
  end
end

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_flash(:info, "Signed up successfully.")
        |> redirect(to: user_path(conn, :my_profile))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def my_profile(conn, _params) do
    user = Auth.my_user(conn)
    render(conn, "show.html", user: user)
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :my_profile))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
