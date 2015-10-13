class CreateBlazerDashboards < ActiveRecord::Migration
  def change
    create_table :blazer_dashboards do |t|
      t.text :name
      t.timestamps
    end

    create_table :blazer_dashboard_queries do |t|
      t.references :blazer_dashboard
      t.references :blazer_query
      t.integer :position
      t.timestamps
    end
  end
end
