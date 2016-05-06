class AddInvertToBlazerChecks < ActiveRecord::Migration
  def change
    add_column :blazer_checks, :invert, :boolean
  end
end
