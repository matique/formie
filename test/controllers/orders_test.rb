require "test_helper"

class OrdersControllerTest < ActionController::TestCase
  test "formie copyright" do
    expected = <<-EOS
      <div class="copyright"> Copyright (c) 2000 </div>
      <p>
        <label> def </label>
        <input type="text" name="def" id="def" />
      </p>
    EOS
    expected = expected.dup
    expected.gsub!(/^ */, "").delete!("\n")

    get :index # faked index
    assert_response :success
    res = response.body.gsub(/^ */, "").delete("\n")
    assert_match(expected, res)
  end
end
