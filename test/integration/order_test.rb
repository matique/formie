# http://blog.crowdint.com/2013/06/14/testing-rails-with-minitest.html

require "test_helper"

describe "Formie" do
  include Capybara::DSL

  before do
    Order.delete_all
    Order.create name: "Rumpelstilzchen"
  end

  it "should display copyright" do
    visit "/orders"

    assert_selector("html", count: 1)
    assert_selector("body", count: 1)
    assert page.has_content?("Copyright")
  end

  it "should list one order" do
    order = Order.all.first

    visit "/orders/#{order.id}"
    # using form_with:
    fnd = 'form p input[name="order[name]"]'
    assert_equal order.name, page.find(fnd).value
    # using form_for:
    # assert_equal order.name, page.find("form p input#order_name").value
    assert_equal "Hello Slim", page.find("form span").text
  end

  it "should remove comments in Slim testing full stack" do
    order = Order.all.first

    visit "/orders/#{order.id}"
    refute page.has_content?("a comment")
  end

  it "builtins" do
    visit "/orders/new"
    assert page.has_content?("action_name new")
    assert page.has_content?("args [123, 456]")
    assert page.has_content?("block 4")
    assert page.has_content?("controller_name orders")
    assert page.has_content?("form ActionView::Helpers::FormBuilder")
    assert page.has_content?("form.object Order")
    assert page.has_content?("params new")
  end
end
