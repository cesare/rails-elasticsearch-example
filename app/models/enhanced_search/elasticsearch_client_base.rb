class EnhancedSearch::ElasticsearchClientBase
  def initialize(config: default_config)
    @config = config
    @client = create_elasticsearch_client(config: config)
  end

  private

  def default_config
    EnhancedSearch::ElasticsearchClientConfig.new
  end

  def create_elasticsearch_client(config:)
    Elasticsearch::Client.new(config.client_parameters)
  end
end
