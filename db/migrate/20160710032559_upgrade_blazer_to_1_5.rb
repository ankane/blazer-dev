class UpgradeBlazerTo15 < ActiveRecord::Migration
  def change
    add_column(:blazer_checks, :check_type, :string)
    add_column(:blazer_checks, :message, :text)
    commit_db_transaction

    Blazer::Check.reset_column_information

    Blazer::Check.where(invert: true).update_all(check_type: "missing_data")
    Blazer::Check.where(check_type: nil).update_all(check_type: "bad_data")
  end
end
