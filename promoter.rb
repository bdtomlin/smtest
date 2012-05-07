class Promoter
  def self.promote(user)
    self.new(user)
  end

  def initialize(user)
    @user = user
  end

  def with(strategy)
    strategy.execute(@user)
  end
end
