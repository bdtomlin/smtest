class Enrollment
  def initialize(user, products)
    @user = user
    @products = products
  end

  def enroll
    sign_up_as_reseller if @products[:reseller]
    sign_up_for_service unless @products[:reseller]
  end

  private

    def sign_up_for_service
      agent = Mechanize.new
      page = agent.get("http://socialmine-staging.com/#{@user.sponsor}/cart")
      process_enrollment(agent, page)
    end

    def sign_up_as_reseller
      agent = Mechanize.new
      product_page = agent.get("http://socialmine-staging.com/#{@user.sponsor}/cart?reseller=true")
      form = product_page.forms.first
      form.checkbox_with(value: "voffice").check if @products[:voffice]
      form.checkbox_with(value: "service").check if @products[:service]

      process_enrollment(agent, agent.submit(form))
    end

    def process_enrollment(agent, page)
      form = page.forms.first
      fill_in_attrs(form)
      confirmation_page = agent.submit(form)
    end

    def fill_in_attrs(form)
      fill_in_subscriber_attrs(form)
      fill_in_billing_address_attrs(form)
      fill_in_payment_info_attrs(form)
    end

    def fill_in_subscriber_attrs(form)
      subscriber_attrs = [:first_name, :last_name, :email, :phone_number, :password,
                          :password_confirmation, :socialmine_id ]
      subscriber_attrs << :commission_id if @products[:reseller]
      subscriber_attrs.each do |attr|
        name = attr.to_s.sub("_confirmation","")
        value = @user.instance_variable_get("@#{name}")
        form.field_with(name: "order[subscriber_attributes][#{attr}]").value = value
      end
    end

    def fill_in_billing_address_attrs(form)
      billing_attrs = [:street_address_1, :city, :zip_code]
      billing_attrs.each do |attr|
        name = attr.to_s.sub("_1","")
        value = @user.address.instance_variable_get("@#{name}")
        form.field_with(name: "order[billing_address_attributes][#{attr}]").value = value
      end
      select_list = form.field_with(name: "order[billing_address_attributes][state]")
      select_list.value = select_list.options[1..49]
    end

    def fill_in_payment_info_attrs(form)
      payment_attrs = [:card_name, :card_number, :card_verification]
      payment_attrs.each do |attr|
        value = @user.payment_information.instance_variable_get("@#{attr}")
        form.field_with(name: "order[payment_info_attributes][#{attr}]").value = value
      end
    end
end
