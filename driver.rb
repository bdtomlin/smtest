require 'mechanize'
require_relative 'user'

# gavin_larkin3694
# gavin_larkin3694 just sponsored gennaro_rice96378
# gavin_larkin3694 just sponsored vivienne_harvey53426
# gavin_larkin3694 just sponsored david_parisian58108
# gennaro_rice96378 just sponsored nichole_reichert17302
# vivienne_harvey53426 just sponsored oran_keebler53743
# david_parisian58108 just sponsored polly_ortiz56503

1.times do
  u = User.new("gavin_larkin3694")
  u.sign_up
  puts u.socialmine_id
  # u.achieve_silver
end
