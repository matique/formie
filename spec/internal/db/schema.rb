ActiveRecord::Schema.define do

  create_table "orders", force: true do |t|
    t.string   "name"
    t.string   "qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
