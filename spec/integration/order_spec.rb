require 'spec_helper'

describe "Formie" do
  before do
    Order.delete_all
    Order.create :name => 'Rumpelstilzchen'
  end

  it 'should display copyright' do
    visit "/orders"
    page.should have_content("Copyright")
  end

  it 'should list one order' do
    order = Order.all.first

    visit "/orders/#{order.id}"
    page.find('form p input').value.should == order.name
  end

  it 'builtins' do
    visit "/orders/new"
    page.should have_content("action_name new")
    page.should have_content("args [123, 456]")
    page.should have_content("block 4")
    page.should have_content("controller_name orders")
    page.should have_content("form ActionView::Helpers::FormBuilder")
    page.should have_content("form.object Order")
    page.should have_content("params new")
  end

end
