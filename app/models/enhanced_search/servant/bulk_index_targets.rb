class EnhancedSearch::Servant::BulkIndexTargets
  def each_batch(&block)
    targets.find_in_batches do |servants|
      entities = create_entity_enumerator(servants)
      block.yield(entities)
    end
  end

  private

  def targets
    Servant.order(:id)
  end

  def create_entity_enumerator(servants)
    Enumerator.new do |y|
      servants.each do |servant|
        y << EnhancedSearch::Servant::IndexEntity.new(servant: servant)
      end
    end
  end
end
