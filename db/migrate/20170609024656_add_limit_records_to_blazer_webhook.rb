class AddLimitRecordsToBlazerWebhook < ActiveRecord::Migration
  def change
    add_column :blazer_webhooks, :limit_records, :integer
  end
end
