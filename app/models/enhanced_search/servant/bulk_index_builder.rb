class EnhancedSearch::Servant::BulkIndexBuilder < EnhancedSearch::BulkIndexBuilder
  private

  def index_base_name
    "servants"
  end

  def index_generator_class
    EnhancedSearch::Servant::IndexGenerator
  end

  def targets
    EnhancedSearch::Servant::BulkIndexTargets.new
  end
end
