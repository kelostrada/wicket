defmodule Wicket.DepositControllerTest do
  use Wicket.ConnCase

  alias Wicket.Deposit
  @valid_attrs %{address: "some content", amount: "120.5", confirmations: 42, pushed: true, pushed_conf: 42, timereceived: 42, tx: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, deposit_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing deposits"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, deposit_path(conn, :new)
    assert html_response(conn, 200) =~ "New deposit"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, deposit_path(conn, :create), deposit: @valid_attrs
    assert redirected_to(conn) == deposit_path(conn, :index)
    assert Repo.get_by(Deposit, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, deposit_path(conn, :create), deposit: @invalid_attrs
    assert html_response(conn, 200) =~ "New deposit"
  end

  test "shows chosen resource", %{conn: conn} do
    deposit = Repo.insert! %Deposit{}
    conn = get conn, deposit_path(conn, :show, deposit)
    assert html_response(conn, 200) =~ "Show deposit"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, deposit_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    deposit = Repo.insert! %Deposit{}
    conn = get conn, deposit_path(conn, :edit, deposit)
    assert html_response(conn, 200) =~ "Edit deposit"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    deposit = Repo.insert! %Deposit{}
    conn = put conn, deposit_path(conn, :update, deposit), deposit: @valid_attrs
    assert redirected_to(conn) == deposit_path(conn, :show, deposit)
    assert Repo.get_by(Deposit, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    deposit = Repo.insert! %Deposit{}
    conn = put conn, deposit_path(conn, :update, deposit), deposit: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit deposit"
  end

  test "deletes chosen resource", %{conn: conn} do
    deposit = Repo.insert! %Deposit{}
    conn = delete conn, deposit_path(conn, :delete, deposit)
    assert redirected_to(conn) == deposit_path(conn, :index)
    refute Repo.get(Deposit, deposit.id)
  end
end
