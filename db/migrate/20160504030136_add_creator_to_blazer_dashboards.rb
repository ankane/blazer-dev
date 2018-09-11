class AddCreatorToBlazerDashboards < ActiveRecord::Migration[5.2]
  def change
    add_column :blazer_dashboards, :creator_id, :integer
    add_column :blazer_checks, :creator_id, :integer
  end
end
