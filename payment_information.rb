require_relative "utilities"

class PaymentInformation
  attr_reader :card_name, :card_number, :card_verification
  def initialize(user_full_name)
    @card_name = user_full_name
    @card_number = generate_credit_card_number
    @card_verification = generate_cvv
    @expiration = generate_expiration_date
  end

  def generate_credit_card_number
    Utilities.random_number_string(16, "4")
  end

  def generate_expiration_date
    { month: Date.today.month, year: Date.today.year + 5 }
  end

  def generate_cvv
    Utilities.random_number_string(3)
  end
end
