class RegistrationsController < Devise::RegistrationsController
  rescue_from Stripe::CardError, Stripe::InvalidRequestError, with: :catch_exception
  
  def create
    @amount = 5
    build_resource(sign_up_params)

    resource.class.transaction do
      if resource.valid? && !User.exists?(email: resource.email)
        process_payment
      else
        handle_registration_errors
      end
    end
  end


  private

  def process_payment
    charge = Stripe::Charge.create(
      amount: (@amount * 100),
      source: params[:stripeToken],
      currency: 'usd'
    )
    
    if charge[:paid]
      register_user
    else
      flash[:alert] = failure_message
      refresh_page
    end
  end

  def register_user
    resource.save
    yield resource if block_given?
    if resource.persisted?
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
    end
  end

  def handle_registration_errors
    if resource.invalid?
      flash[:alert] = resource.errors.full_messages.join(', ')
    else
      flash[:alert] = "Email has already been taken"
    end
    refresh_page
  end

  def refresh_page
    clean_up_passwords resource
    set_minimum_password_length
    respond_with resource
  end

  def failure_message
    "We are sorry. We are unable to proceed with your request. Please try again later."
  end

  def catch_exception(exception)
    flash[:alert] = "#{exception.message}"
    redirect_back fallback_location: root_path
  end
end