require_relative 'user'
require_relative 'depth_tester'
require_relative 'silver_strategy'
require_relative 'gold_strategy'
require_relative 'ruby_strategy'
require_relative 'diamond_strategy'

u = User.with_sponsor("therock")
# u = User.new("adonis_crist8114667")
# u = User.new("therock", "sociallink")
# u.email = "bdtomlin+socialtwit2@gmail.com"
# optionally pass these to sign up
# service_only, no_voffice, no_service
u.sign_up
# u.sign_up(no_voffice: true, no_service: true)
# u.sign_up(service_only: true)


# promote user to selected rank
# u.promote_with(SilverStrategy.new)
# u.promote_with(GoldStrategy.new)
# u.promote_with(RubyStrategy.new)
# u.promote_with(DiamondStrategy.new)

# put some depth to test the tree view
# u = User.new("therock", "leonardo_casper1256535")
# users = [u]
# 10.times do
#   users << users.last.sponsor_someone
# end

# test the depth reqirement
# DepthTester.test(:ruby).includes_depth(10)
# DepthTester.test(:ruby).excludes_depth(10)
