require 'faker'
require_relative 'payment_information'
require_relative 'address'
require_relative 'utilities'
require_relative 'enrollment'
require_relative 'promoter'

class User
  attr_reader :sponsor, :first_name, :last_name, :socialmine_id, :email,
              :password, :commission_id, :address, :payment_information

  def self.with_sponsor(sponsor)
    self.new(sponsor)
  end

  def initialize(sponsor, socialmine_id = nil)
    @sponsor = sponsor
    @first_name = Faker::Name.first_name
    @last_name = Faker::Name.last_name
    @socialmine_id = socialmine_id || generate_socialmine_id
    @email = "#@socialmine_id@example.com"
    @phone_number = Utilities::random_number_string(10)
    @password = "password"
    @commission_id = Utilities::random_number_string(9)
    @address = Address.new
    @payment_information = PaymentInformation.new(full_name)
    print "#{@socialmine_id} (spon: #{@sponsor})\n"
  end

  def generate_socialmine_id
    name = full_name
    name.gsub!(" ", "_")
    ["'", ".", ","].each { |char| name.gsub!(char, '') }
    "#{name.downcase}#{rand(10000000)}"
  end

  def full_name
    @first_name + ' ' + @last_name
  end

  def sign_up(options = {})
    e = Enrollment.new(self, options)
    e.enroll
  end

  def promote_with(strategy)
    Promoter.promote(self).with(strategy)
  end

  def sponsor_a_service_only
    sponsored_user = User.new(@socialmine_id)
    sponsored_user.sign_up(service_only: true)
    sponsored_user
  end

  def sponsor_someone
    sponsored_user = User.new(@socialmine_id)
    sponsored_user.sign_up
    sponsored_user
  end
end
