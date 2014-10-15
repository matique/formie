require 'spec_helper'

describe OrdersController, ':' do
  render_views

  it 'checking formie copyright' do
    get :index
    expect(response.body).to match(/copyright/)
    expect(response.body).to match(/Copyright/)
    expect(response.body).to match(/label/)
    expect(response.body).to match(/input/)
    expect(response.body).to match(/def/)
  end

end
