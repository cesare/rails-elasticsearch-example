class EnhancedSearch::Servant::BulkIndexBuilder < EnhancedSearch::BulkIndexBuilder
  private

  def index_base_name
    "servants"
  end

  def index_settings
    EnhancedSearch::Servant::SettingsFactory.new.create
  end

  def index_mappings
    EnhancedSearch::Servant::MappingsFactory.new.create
  end

  def targets
    EnhancedSearch::Servant::BulkIndexTargets.new
  end
end
