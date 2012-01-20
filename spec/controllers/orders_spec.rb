require 'spec_helper'

describe OrdersController, ':' do
  render_views

  it 'checking formie copyright' do
    get :index
    response.body.should =~ /copyright/
    response.body.should =~ /Copyright/
    response.body.should =~ /label/
    response.body.should =~ /input/
    response.body.should =~ /def/
  end

end
