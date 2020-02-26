class EnhancedSearch::IndexEntity
  def identifier
    fail NotImplementedError
  end

  def create_index_document
    fail NotImplementedError
  end
end
