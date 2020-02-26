class EnhancedSearch::Servant::BulkInserter < EnhancedSearch::BulkInserter
  private

  def target_records
    Servant.order(:id)
  end

  def create_index_document(servant)
    {
      name: servant.name,
      class_label: servant.class_label,
      rarity: servant.rarity,
    }
  end
end
