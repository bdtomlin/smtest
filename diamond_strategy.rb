require_relative 'ruby_strategy'

class DiamondStrategy < Strategy
  def execute(user)
    @user = user

    Promoter.promote(@user).with(RubyStrategy.new)

    add_members(5)

    sponsor_users(3) do |user|
      Promoter.promote(user).with(RubyStrategy.new)
    end

    report(@user.socialmine_id, :diamond)
  end
end
