class EnhancedSearch::BulkEntityIndexer < EnhancedSearch::ElasticsearchClientBase
  def initialize(config: default_config, index_name:)
    super(config: config)
    @index_name = index_name
  end

  def index(entities:)
    body = create_indexing_body(entities)
    @client.bulk(body: body)
  end

  private

  attr_reader :index_name

  def create_indexing_body(entities)
    entities.map do |entity|
      create_indexing_parameters(entity)
    end
  end

  def create_indexing_parameters(entity)
    {
      index: {
        _index: index_name,
        _id: entity.identifier,
        data: entity.create_index_document,
      }
    }
  end
end
