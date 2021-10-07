class CreateBakingProcedureData < ActiveRecord::Migration[6.1]
  def up
    Baking::Procedure.create(description: "4@400", minimum: 375, maximum: 425, setpoint: 400, soak_length: 240, profile_name: nil)
    Baking::Procedure.create(description: "5@450", minimum: 425, maximum: 475, setpoint: 450, soak_length: 300, profile_name: nil)
    Baking::Procedure.create(description: "SMALOG", minimum: 700, maximum: 750, setpoint: 725, soak_length: 60, profile_name: "SMALOG")
  end
  def down
    Baking::Procedure.delete_all
  end
end