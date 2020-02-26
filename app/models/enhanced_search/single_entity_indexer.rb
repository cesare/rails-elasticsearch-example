class EnhancedSearch::SingleEntityIndexer < EnhancedSearch::ElasticsearchClientBase
  attr_reader :index_name

  def initialize(config: default_config, index_name:)
    super(config: config)
    @index_name = index_name
  end

  def index(entity:)
    id = entity.identifier
    document = entity.create_index_document
    @client.index(index: index_name, id: id, body: document)
  end
end
