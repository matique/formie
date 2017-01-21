class Order < ActiveRecord::Base

  before_save { |row|
    row.errors.add(:base, 'panic')  if row.name == 'error'
  }

end
