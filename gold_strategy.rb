require_relative 'silver_strategy'

class GoldStrategy < Strategy
  def execute(user)
    @user = user

    Promoter.promote(@user).with(SilverStrategy.new)

    add_members(1)

    sponsor_users(3) do |user|
      Promoter.promote(user).with(SilverStrategy.new)
    end

    report(@user.socialmine_id, :gold)
  end
end
