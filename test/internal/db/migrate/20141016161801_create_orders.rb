class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :qty

      t.timestamps null: false
    end
  end
end
