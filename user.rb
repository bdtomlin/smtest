require 'faker'
require 'mechanize'
require_relative 'payment_information'
require_relative 'address'
require_relative 'utilities'
require_relative 'enrollment'

class User
  attr_reader :sponsor, :first_name, :last_name, :socialmine_id, :email,
              :password, :commission_id, :address, :payment_information

  def initialize(sponsor = "therock")
    @sponsor = sponsor
    @first_name = Faker::Name.first_name
    @last_name = Faker::Name.last_name
    @socialmine_id = generate_socialmine_id
    @email = "#@socialmine_id@example.com"
    @phone_number = Utilities::random_number_string(10)
    @password = "password"
    @commission_id = Utilities::random_number_string(9)
    @address = Address.new
    @payment_information = PaymentInformation.new(full_name)
  end

  def generate_socialmine_id
    name = full_name
    name.gsub!(" ", "_")
    name.gsub!("'", "")
    name.gsub!(".", "")
    name.gsub!(",", "")
    "#{name}#{rand(100000)}".downcase
  end

  def full_name
    @first_name + ' ' + @last_name
  end

  def sign_up(products = {reseller: true, service: true, voffice: true})
    e = Enrollment.new(self, products)
    e.enroll
  end

  def achieve_silver
    users = []

    3.times do
      users << sponsor_someone
    end

    users.each {|user| user.sponsor_someone }
    end
  end

  def achieve_gold
    achieve_silver

    3.times do
      users << sponsor_someone
    end

    users.each { |user| user.achieve_silver }
  end

  def sponsor_someone
    sponsored_user = User.new(@socialmine_id)
    sponsored_user.sign_up
    puts "#{@socialmine_id} just sponsored #{sponsored_user.socialmine_id}"
    sponsored_user
  end
end
