class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action do
    Formie.reload if Rails.env == "development"
  end
end
