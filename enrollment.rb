require 'mechanize'

class Enrollment
  def initialize(user, options)
    @user = user
    @options = options
  end

  def enroll
    if @options[:service_only]
      sign_up_for_service
    else
      sign_up_as_reseller
    end
  end

  private

    def try_3
      times_tried = 0
      begin
        yield
      rescue
        times_tried += 1
        puts times_tried
        sleep 2
        retry if times_tried < 3
        raise
      end
    end

    def agent
      @agent ||= Mechanize.new
    end

    def get(url)
      try_3 { agent.get(url) }
    end

    def sign_up_for_service
      page = get("http://socialmine-staging.com/#{@user.sponsor}")
      page = page.link_with(text: 'Sign Up Now').click
      process_enrollment(agent, page)
    end

    def sign_up_as_reseller
      page = get("http://socialmine-staging.com/#{@user.sponsor}/cart?reseller=true")
      form = page.forms.first
      form.checkbox_with(value: "voffice").check unless @options[:no_voffice]
      form.checkbox_with(value: "service").check unless @options[:no_service]

      process_enrollment(agent, agent.submit(form))
    end

    def process_enrollment(agent, page)
      form = page.forms.first
      fill_in_attrs(form)
      confirmation_page = try_3 { agent.submit(form) }
      unless confirmation_page.search(".flash>h1").text.strip =~ /^Thank you/
        puts "ERROR: enroll problem for #{@user.socialmine_id}"
        confirmation_page.search(".field_with_errors").each do |el|
          puts el.text
        end
      end
    end

    def fill_in_attrs(form)
      fill_in_subscriber_attrs(form)
      fill_in_billing_address_attrs(form)
      fill_in_payment_info_attrs(form)
    end

    def fill_in_subscriber_attrs(form)
      subscriber_attrs = [:first_name, :last_name, :email, :phone_number, :password,
                          :password_confirmation, :socialmine_id ]
      subscriber_attrs << :commission_id unless @options[:service_only]
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
