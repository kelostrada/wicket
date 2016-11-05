defmodule Wicket.WithdrawalTest do
  use Wicket.ModelCase

  alias Wicket.Withdrawal

  @valid_attrs %{address: "some content", amount: "120.5", confirmations: 42, connector: "some content", external_id: "some content", fee: "120.5", pushed: true, pushed_conf: 42, timereceived: 42, tx: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Withdrawal.changeset(%Withdrawal{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Withdrawal.changeset(%Withdrawal{}, @invalid_attrs)
    refute changeset.valid?
  end
end
