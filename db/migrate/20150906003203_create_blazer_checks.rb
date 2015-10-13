class CreateBlazerChecks < ActiveRecord::Migration
  def change
    create_table :blazer_checks do |t|
      t.references :blazer_query
      t.string :state
      t.text :emails
      t.timestamps
    end
  end
end
