class CreateBakeCycles < ActiveRecord::Migration[6.1]
  def change
    create_table :bake_cycles do |t|
      t.string      :type,                  null: false
      t.string      :oven,                  null: true,   default: nil
      t.string      :side,                  null: true,   default: nil
      t.boolean     :is_locked,             null: false,  default: false
      t.datetime    :cycle_started_at,      null: true,   default: nil
      t.datetime    :loadings_finished_at,  null: true,   default: nil
      t.datetime    :purge_finished_at,     null: true,   default: nil
      t.datetime    :soak_started_at,       null: true,   default: nil
      t.datetime    :soak_ended_at,         null: true,   default: nil
      t.datetime    :gas_off_at,            null: true,   default: nil
      t.datetime    :cooling_finished_at,   null: true,   default: nil
      t.datetime    :cycle_ended_at,        null: true,   default: nil
      t.string      :profile_name,          null: true,   default: nil
      t.float       :psi_consumed,          null: true,   default: nil
      t.boolean     :used_cooling_profile,  null: true,   default: nil
      t.references  :user,                  null: true,   default: nil, foreign_key: true
      t.timestamps
    end
  end
end