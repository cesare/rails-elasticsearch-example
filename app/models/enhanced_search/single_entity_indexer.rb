class EnhancedSearch::SingleEntityIndexer < EnhancedSearch::ElasticsearchClientBase
  def index(entity:)
    id = entity.identifier
    document = entity.create_index_document
    @client.index(index: index_name, id: id, body: document)
  end

  private

  def index_name
    fail NotImplementedError
  end
end
