class Order < ActiveRecord::Base

  before_save do |row|
    return true  unless row.name == 'error'

    row.errors.add :base, 'panic'
    return false
  end

end
