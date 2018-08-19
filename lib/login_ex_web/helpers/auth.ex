defmodule LoginExWeb.Helpers.Auth do
  alias LoginEx.Accounts
  def signed_in?(conn) do
    login_id = Plug.Conn.get_session(conn, :current_login_id)
    if login_id, do: !!LoginEx.Repo.get(LoginEx.Accounts.Login, login_id)
  end

  def my_login(conn) do
    login_id = Plug.Conn.get_session(conn, :current_login_id)
    login = Accounts.get_login!(login_id)
  end


  def is_admin?(conn) do
      login_id = Plug.Conn.get_session(conn, :current_login_id)
      login = Accounts.get_login!(login_id)
    if login.is_admin == true, do: !!LoginEx.Repo.get(LoginEx.Accounts.Login, login_id)
  end
end
