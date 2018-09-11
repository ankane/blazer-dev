class AddScheduleAndLastRunAtToBlazerChecks < ActiveRecord::Migration[5.2]
  def change
    add_column :blazer_checks, :schedule, :string
    add_column :blazer_checks, :last_run_at, :timestamp
  end
end
