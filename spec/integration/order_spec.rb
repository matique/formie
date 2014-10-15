require 'spec_helper'

describe "Formie" do
  before do
    Order.delete_all
    Order.create :name => 'Rumpelstilzchen'
  end

  it 'should display copyright' do
    visit "/orders"
    expect(page).to have_content("Copyright")
  end

  it 'should list one order' do
    order = Order.all.first

    visit "/orders/#{order.id}"
    expect(page.find('form p input#order_name').value).to eq(order.name)
    expect(page.find('form span').text).to eq('Hello Slim')
  end

  it 'builtins' do
    visit "/orders/new"
    expect(page).to have_content("action_name new")
    expect(page).to have_content("args [123, 456]")
    expect(page).to have_content("block 4")
    expect(page).to have_content("controller_name orders")
    expect(page).to have_content("form ActionView::Helpers::FormBuilder")
    expect(page).to have_content("form.object Order")
    expect(page).to have_content("params new")
  end

end
