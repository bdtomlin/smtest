require_relative 'ruby_strategy'

class DiamondStrategy2 < Strategy
  def execute(user)
    @user = user

    Promoter.promote(@user).with(RubyStrategy.new)

    add_members(5)

    sponsor_users(3) do |user|
      level_2_user = user.sponsor_someone
      Promoter.promote(level_2_user).with(RubyStrategy.new)
    end

    report(@user.socialmine_id, :diamond)
  end
end
