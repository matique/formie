class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action do
    Formie.reload  if 'development' == Rails.env
  end

end
