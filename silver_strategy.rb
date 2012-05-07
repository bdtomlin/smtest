require_relative 'Strategy'

class SilverStrategy < Strategy
  def execute(user)
    @user = user

    sponsor_users(3) do |user|
      user.sponsor_someone
    end

    report(@user.socialmine_id, :silver)
  end
end
