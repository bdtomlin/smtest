require_relative 'gold_strategy'

class RubyStrategy < Strategy
  def execute(user)
    @user = user

    Promoter.promote(@user).with(GoldStrategy.new)

    add_members(2)

    sponsor_users(3) do |user|
      level_2_user = user.sponsor_someone
      Promoter.promote(level_2_user).with(GoldStrategy.new)
    end

    report(@user.socialmine_id, :ruby)
  end
end
