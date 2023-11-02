defmodule RealDealApiWeb.DefaultController do
  use RealDealApiWeb, :controller

  def index(conn, _params) do
    json conn, %{status: :ok, msg: "The RealDealApi is LIVE - #{Mix.env()}" }
  end
end
