defmodule Wicket.WithdrawalControllerTest do
  use Wicket.ConnCase

  alias Wicket.Withdrawal
  @valid_attrs %{address: "some content", amount: "120.5", confirmations: 42, connector: "some content", external_id: "some content", fee: "120.5", pushed: true, pushed_conf: 42, timereceived: 42, tx: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, withdrawal_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing withdrawals"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, withdrawal_path(conn, :new)
    assert html_response(conn, 200) =~ "New withdrawal"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, withdrawal_path(conn, :create), withdrawal: @valid_attrs
    assert redirected_to(conn) == withdrawal_path(conn, :index)
    assert Repo.get_by(Withdrawal, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, withdrawal_path(conn, :create), withdrawal: @invalid_attrs
    assert html_response(conn, 200) =~ "New withdrawal"
  end

  test "shows chosen resource", %{conn: conn} do
    withdrawal = Repo.insert! %Withdrawal{}
    conn = get conn, withdrawal_path(conn, :show, withdrawal)
    assert html_response(conn, 200) =~ "Show withdrawal"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, withdrawal_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    withdrawal = Repo.insert! %Withdrawal{}
    conn = get conn, withdrawal_path(conn, :edit, withdrawal)
    assert html_response(conn, 200) =~ "Edit withdrawal"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    withdrawal = Repo.insert! %Withdrawal{}
    conn = put conn, withdrawal_path(conn, :update, withdrawal), withdrawal: @valid_attrs
    assert redirected_to(conn) == withdrawal_path(conn, :show, withdrawal)
    assert Repo.get_by(Withdrawal, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    withdrawal = Repo.insert! %Withdrawal{}
    conn = put conn, withdrawal_path(conn, :update, withdrawal), withdrawal: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit withdrawal"
  end

  test "deletes chosen resource", %{conn: conn} do
    withdrawal = Repo.insert! %Withdrawal{}
    conn = delete conn, withdrawal_path(conn, :delete, withdrawal)
    assert redirected_to(conn) == withdrawal_path(conn, :index)
    refute Repo.get(Withdrawal, withdrawal.id)
  end
end
