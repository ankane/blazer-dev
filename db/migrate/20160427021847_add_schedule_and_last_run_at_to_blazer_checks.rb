class AddScheduleAndLastRunAtToBlazerChecks < ActiveRecord::Migration
  def change
    add_column :blazer_checks, :schedule, :string
    add_column :blazer_checks, :last_run_at, :timestamp
  end
end
