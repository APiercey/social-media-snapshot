defmodule SocialMediaIntegration.Repo.Migrations.AddMoreFieldsToSnapshots do
  use Ecto.Migration

  def change do
    alter table("snapshots") do
      add(:first_name, :string)
      add(:last_name, :string)
    end
  end
end
