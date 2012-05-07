require_relative 'user'

class DepthTester
  def self.test(rank)
    self.new(rank)
  end

  def initialize(rank, level)
    @rank = rank
    @level = level
  end

  def includes_depth(depth)
    @depth = depth
    tested_user = build_team
    report "#{tested_user.socialmine_id} should have one #{@rank} team member lit up"
  end

  def excludes_depth(depth)
    @depth = depth
    tested_user = build_team
    report "#{tested_user.socialmine_id} should not have any #{@rank} team members lit up"
  end

  def report(message)
    puts "### Results for level #{@depth} ###"
    puts message
    puts "###########################"
  end

  def build_team
    tested_user = User.new("therock")
    tested_user.sign_up
    rank_method_sym = "achieve_#{@rank}".to_sym
    tested_user.send(rank_method_sym)

    u = tested_user

    (1..depth).each do |i|
      puts "### Level #{i} ###"
      u = User.new(u.socialmine_id)
      u.sign_up
    end

    u.send(rank_method_sym)

    tested_user
  end

end
