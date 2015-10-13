class AddDataSourcesToBlazer < ActiveRecord::Migration
  def change
    rename_column :blazer_checks, :blazer_query_id, :query_id
    rename_column :blazer_dashboard_queries, :blazer_dashboard_id, :dashboard_id
    rename_column :blazer_dashboard_queries, :blazer_query_id, :query_id
    add_column :blazer_queries, :data_source, :text
    add_column :blazer_audits, :data_source, :text
    # Blazer::Query.where(data_source: nil).update_all(data_source: "main")
    # Blazer::Audit.where(data_source: nil).update_all(data_source: "main")
  end
end
