class InstallBlazerWebhooks < ActiveRecord::Migration
  def change
    create_table :blazer_webhooks do |t|
      t.references :creator
      t.references :check
      t.string :name
      t.string :uri
      t.string :auth_header_name
      t.string :auth_header_value
      t.text :states
      t.timestamps
    end

    create_table :blazer_webhook_events do |t|
      t.references :creator
      t.references :webhook
      t.timestamp :run_at
      t.string :state
      t.integer :return_code
      t.string :check_sum
      t.timestamps
    end
  end
end
