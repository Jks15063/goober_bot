defmodule GooberBot.Factory do
  use ExMachina.Ecto, repo: GooberBot.Repo

  alias GooberBot.{Match, Set, User}

  def match_factory do
    %Match{
      set: build(:set),
      player1: build(:user),
      player2: build(:user),
      winner: build(:user)
    }
  end

  def set_factory do
    %Set{
      matches_to_win: 10,
      status: :open,
      player1: build(:user),
      player2: build(:user),
      winner: build(:user)
    }
  end

  def user_factory do
    %User{
      avatar: Faker.Name.name(),
      bot: false,
      discriminator: Faker.Beer.brand(),
      mfa_enabled: false,
      user_id: Faker.Util.format("%18d"),
      username: Faker.Pokemon.name(),
      verified: false
    }
  end
end
