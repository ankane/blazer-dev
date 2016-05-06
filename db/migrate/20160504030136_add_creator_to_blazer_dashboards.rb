class AddCreatorToBlazerDashboards < ActiveRecord::Migration
  def change
    add_column :blazer_dashboards, :creator_id, :integer
    add_column :blazer_checks, :creator_id, :integer
  end
end
