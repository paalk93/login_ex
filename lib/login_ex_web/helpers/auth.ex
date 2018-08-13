defmodule LoginExWeb.Helpers.Auth do
  alias LoginEx.Accounts
  def signed_in?(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    if user_id, do: !!LoginEx.Repo.get(LoginEx.Accounts.User, user_id)
  end

  def my_user(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    user = Accounts.get_user!(user_id)
  end


  def is_admin?(conn) do
      user_id = Plug.Conn.get_session(conn, :current_user_id)
      user = Accounts.get_user!(user_id)
    if user.is_admin == true, do: !!LoginEx.Repo.get(LoginEx.Accounts.User, user_id)
  end
end
