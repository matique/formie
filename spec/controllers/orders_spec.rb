require 'spec_helper'

describe OrdersController, ':' do
  render_views

  it 'checking formie copyright' do
    get :index
    response.body.should =~ /copyright/
  end

end
