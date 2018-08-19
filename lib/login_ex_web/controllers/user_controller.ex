defmodule LoginExWeb.UserController do
  use LoginExWeb, :controller

  alias LoginEx.Repo
  alias LoginEx.Accounts
  alias LoginEx.Accounts.Login
  alias LoginEx.Accounts.User
  alias LoginExWeb.Helpers.Auth


plug :check_auth when action in [:my_profile]

defp check_auth(conn, _args) do
  if login_id = get_session(conn, :current_login_id) do
  current_login = Accounts.get_login!(login_id)
  conn
    |> assign(:current_login, current_login)
  else
    conn
    |> put_flash(:error, "You need to be signed in to access this page.")
    |> redirect(to: page_path(conn, :index))
    |> halt()
  end
end

plug :check_admin_auth when action in [:index]

defp check_admin_auth(conn, _args) do
  if login_id = get_session(conn, :current_login_id) do
  current_login = Accounts.get_login!(login_id)
  if current_login.is_admin == true do
  conn
    |> assign(:current_login, current_login)
  else
    conn
    |> put_flash(:error, "Access denied.")
    |> redirect(to: page_path(conn, :index))
    |> halt()
  end
  end
end

  def index(conn, _params) do
    logins = Accounts.list_logins()
    render(conn, "index.html", logins: logins)
  end

  def new(conn, _params) do
    changeset = Accounts.change_login(%Login{user: %User{}})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"login" => login_params}) do
    case Accounts.create_login(login_params) do
      {:ok, login} ->
        conn
        |> put_session(:current_login_id, login.id)
        |> put_flash(:info, "Signed up successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def my_profile(conn, _params) do
    login = Auth.my_login(conn)
    render(conn, "show.html", login: login)
  end

  def show(conn, %{"id" => id}) do
    login = Accounts.get_login!(id)
    user = Accounts.get_user!(id)
    render(conn, "show.html", login: login)
  end

  def edit(conn, %{"id" => id}) do
    login = Accounts.get_login!(id)
    changeset = Accounts.change_login(login)
    render(conn, "edit.html", login: login, changeset: changeset)
  end

  def update(conn, %{"id" => id, "login" => login_params}) do
    login = Accounts.get_login!(id)

    case Accounts.update_login(login, login_params) do
      {:ok, login} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :my_profile))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", login: login, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    login = Accounts.get_login!(id)
    {:ok, _login} = Accounts.delete_login(login)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
