module DemoModel
  extend ActiveSupport::Concern

  included do
    validate :prevent_save
  end

  def prevent_save
    errors.add(:base, "Sorry, not in the demo") if ENV["DEMO"].present?
  end

  def destroy
    super unless ENV["DEMO"].present?
  end
end

[
  Blazer::Query,
  Blazer::Dashboard,
  Blazer::DashboardQuery,
  Blazer::Check
].each do |model|
  model.send(:include, DemoModel)
end

if ENV["DEMO"].present?
  class Blazer::Check
    def update_state(*args)
      # do nothing
    end
  end
end
