require 'test/unit'
require 'active_record'
require 'action_view'

require File.dirname(__FILE__) + '/../lib/formie.rb'

ActiveRecord::Base.establish_connection({
  :adapter => 'postgresql',
  :database => 'docu_test'
})

ActiveRecord::Schema.define do
  create_table 'orders', :force => true do |t|
    t.column 'name', :string
    t.column 'bag', :text
  end
end


class Rails
  def self.root
    File.dirname(__FILE__)
  end
end
