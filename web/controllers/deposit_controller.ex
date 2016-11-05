defmodule Wicket.DepositController do
  use Wicket.Web, :controller

  alias Wicket.Deposit

  def index(conn, _params) do
    deposits = Repo.all(Deposit)
    render(conn, "index.html", deposits: deposits)
  end

  def new(conn, _params) do
    changeset = Deposit.changeset(%Deposit{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"deposit" => deposit_params}) do
    changeset = Deposit.changeset(%Deposit{}, deposit_params)

    case Repo.insert(changeset) do
      {:ok, _deposit} ->
        conn
        |> put_flash(:info, "Deposit created successfully.")
        |> redirect(to: deposit_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    deposit = Repo.get!(Deposit, id)
    render(conn, "show.html", deposit: deposit)
  end

  def edit(conn, %{"id" => id}) do
    deposit = Repo.get!(Deposit, id)
    changeset = Deposit.changeset(deposit)
    render(conn, "edit.html", deposit: deposit, changeset: changeset)
  end

  def update(conn, %{"id" => id, "deposit" => deposit_params}) do
    deposit = Repo.get!(Deposit, id)
    changeset = Deposit.changeset(deposit, deposit_params)

    case Repo.update(changeset) do
      {:ok, deposit} ->
        conn
        |> put_flash(:info, "Deposit updated successfully.")
        |> redirect(to: deposit_path(conn, :show, deposit))
      {:error, changeset} ->
        render(conn, "edit.html", deposit: deposit, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    deposit = Repo.get!(Deposit, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(deposit)

    conn
    |> put_flash(:info, "Deposit deleted successfully.")
    |> redirect(to: deposit_path(conn, :index))
  end
end
