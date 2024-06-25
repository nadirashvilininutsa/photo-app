Rails.configuration.stripe = {
  publishable_key: Rails.application.credentials.STRIPE_TEST_PUBLISHABLE_KEY,
  secret_key: Rails.application.credentials.STRIPE_TEST_SECRET_KEY
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
