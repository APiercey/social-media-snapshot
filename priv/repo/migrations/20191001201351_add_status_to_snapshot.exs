defmodule SocialMediaIntegration.Repo.Migrations.AddStatusToSnapshot do
  use Ecto.Migration

  def change do
    alter table("snapshots") do
      add(:status, :string)
    end
  end
end
