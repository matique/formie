require 'test_helper'

class Order < ActiveRecord::Base
end

class FormieTest < ActionView::TestCase

  def setup
    Formie::Load.reload
  end

  test "loading formies" do
    v = ::ActionView::Helpers::TextHelper.public_instance_methods.sort
    b = ::ActionView::Helpers::FormBuilder.public_instance_methods.sort

    assert v.include?(:copyright)
    assert b.include?(:l_field)

    assert !b.include?(:copyright)
    assert !v.include?(:l_field)
  end

  test "copyright" do
    assert_match /copyright/, copyright(2000)
  end

  test "l_field" do
## not working; test environment
#    row = Order.new
#    formie_for row do |f|
#      res = f.l_field :field => :name
#    end
  end

  test "formie_for" do
## not working; test environment
#    row = Order.new
#    formie_for row do |f|
#      res = f.l_field :field => :name
#    end
  end

end

