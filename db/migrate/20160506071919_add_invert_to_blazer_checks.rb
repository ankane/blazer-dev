class AddInvertToBlazerChecks < ActiveRecord::Migration[5.2]
  def change
    add_column :blazer_checks, :invert, :boolean
  end
end
