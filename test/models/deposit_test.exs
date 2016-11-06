defmodule Wicket.DepositTest do
  use Wicket.ModelCase

  alias Wicket.Deposit

  @valid_attrs %{address: "some content", amount: "120.5", confirmations: 42, connector: "some content", pushed: true, pushed_conf: 42, timereceived: 42, txid: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Deposit.changeset(%Deposit{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Deposit.changeset(%Deposit{}, @invalid_attrs)
    refute changeset.valid?
  end
end
