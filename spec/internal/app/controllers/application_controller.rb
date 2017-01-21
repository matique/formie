class ApplicationController < ActionController::Base

=begin
  if Rails.version < '5.0.0'
    before_filter do
      Formie.reload  unless Rails.env.production?
    end
  else
    before_action do
      Formie.reload  unless Rails.env.production?
    end
  end
=end

end
