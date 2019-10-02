defmodule SocialMediaSnapshot.Repo.Migrations.AddSnapshotSchema do
  use Ecto.Migration

  def change do
    create table(:snapshots) do
      add(:uuid, :string, null: false)
      add(:user_id, :string, null: false)
    end

    create(unique_index(:snapshots, [:uuid]))
  end
end
