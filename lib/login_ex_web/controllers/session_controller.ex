defmodule LoginExWeb.SessionController do
  use LoginExWeb, :controller

  alias LoginEx.Accounts

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => auth_params}) do
    login = Accounts.get_by_username(auth_params["username"])
    case Comeonin.Pbkdf2.check_pass(login, auth_params["password"]) do
      {:ok, login} ->
        conn
        |> put_session(:current_login_id, login.id)
        |> put_flash(:info, "Signed in successfully")
        |> redirect(to: page_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:error, "There was a problem with your username/password.")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_login_id)
    |> put_flash(:info, "Signed out successfully.")
    |> redirect(to: page_path(conn, :index))
  end
end
