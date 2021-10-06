class CreateBakingProcedureAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :baking_procedure_assignments do |t|
      t.references  :procedure,             null: false,  index: true,    foreign_key: { to_table: :baking_procedures }
      t.references  :cycle,                 null: false,  index: true,    foreign_key: { to_table: :baking_cycles }
      t.timestamps
    end
  end
end