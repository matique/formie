class Order < ActiveRecord::Base

  before_save :before_save_x
  def before_save_x
    return true  unless name == 'error'

    self.errors.add :base, 'panic'
    return false
  end

end
