class CreateScanDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :scan_documents do |t|
      t.timestamps
    end
  end
end