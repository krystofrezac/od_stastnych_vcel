defmodule Bees.Release do
  @moduledoc false

  @app :bees

  @spec migrate() :: any()
  def migrate do
    for repo <- repos() do
      # credo:disable-for-next-line Credo.Check.Consistency.UnusedVariableNames
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  @spec rollback(Ecto.Repo.t(), integer()) :: {:ok, any(), any()}
  def rollback(repo, version) do
    # credo:disable-for-next-line Credo.Check.Consistency.UnusedVariableNames
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.load(@app)
    Application.fetch_env!(@app, :ecto_repos)
  end
end
