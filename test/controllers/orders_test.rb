require 'test_helper'

class OrdersControllerTest < ActionController::TestCase

  test 'checking formie copyright' do
    get :index
    assert_response :success
    assert_match(/copyright/, response.body)
    assert_match(/Copyright/, response.body)
    assert_match(/label/    , response.body)
    assert_match(/input/    , response.body)
    assert_match(/def/      , response.body)
  end

end
