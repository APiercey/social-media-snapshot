defmodule SocialMediaSnapshotTest do
  use ExUnit.Case
  doctest SocialMediaSnapshot

  test "greets the world" do
    assert SocialMediaSnapshot.hello() == :world
  end
end
