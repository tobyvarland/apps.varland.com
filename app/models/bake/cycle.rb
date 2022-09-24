class Bake::Cycle < ApplicationRecord

  # Associations.
  belongs_to  :user,
              optional: true
  has_many  :shop_orders,
            inverse_of: 'cycle',
            foreign_key: 'cycle_id'
  has_many  :loads,
            through: :shop_orders

  # Instance methods.

  # Sets timestamp for all "loaded" loads.
  def set_load_timestamps
    current = Time.current
    self.loads.where(not_loaded: false).where(started_baking_at: nil).each do |load|
      load.update(started_baking_at: current)
    end
  end

end