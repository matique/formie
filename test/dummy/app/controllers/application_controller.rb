class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter do
    Formie.reload  if 'development' == Rails.env
  end

end
