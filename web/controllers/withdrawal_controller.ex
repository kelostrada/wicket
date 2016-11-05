defmodule Wicket.WithdrawalController do
  use Wicket.Web, :controller

  alias Wicket.Withdrawal

  def index(conn, _params) do
    withdrawals = Repo.all(Withdrawal)
    render(conn, "index.html", withdrawals: withdrawals)
  end

  def new(conn, _params) do
    changeset = Withdrawal.changeset(%Withdrawal{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"withdrawal" => withdrawal_params}) do
    changeset = Withdrawal.changeset(%Withdrawal{}, withdrawal_params)

    case Repo.insert(changeset) do
      {:ok, _withdrawal} ->
        conn
        |> put_flash(:info, "Withdrawal created successfully.")
        |> redirect(to: withdrawal_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    withdrawal = Repo.get!(Withdrawal, id)
    render(conn, "show.html", withdrawal: withdrawal)
  end

  def edit(conn, %{"id" => id}) do
    withdrawal = Repo.get!(Withdrawal, id)
    changeset = Withdrawal.changeset(withdrawal)
    render(conn, "edit.html", withdrawal: withdrawal, changeset: changeset)
  end

  def update(conn, %{"id" => id, "withdrawal" => withdrawal_params}) do
    withdrawal = Repo.get!(Withdrawal, id)
    changeset = Withdrawal.changeset(withdrawal, withdrawal_params)

    case Repo.update(changeset) do
      {:ok, withdrawal} ->
        conn
        |> put_flash(:info, "Withdrawal updated successfully.")
        |> redirect(to: withdrawal_path(conn, :show, withdrawal))
      {:error, changeset} ->
        render(conn, "edit.html", withdrawal: withdrawal, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    withdrawal = Repo.get!(Withdrawal, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(withdrawal)

    conn
    |> put_flash(:info, "Withdrawal deleted successfully.")
    |> redirect(to: withdrawal_path(conn, :index))
  end
end
