module Utilities
  def self.random_number_string(length, str = '')
    length = length - str.length
    length.times { str << rand(0..9).to_s }
    str
  end
end
