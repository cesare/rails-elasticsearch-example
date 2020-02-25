class EnhancedSearch::IndexGenerator < EnhancedSearch::ElasticsearchClientBase
  def initialize(config: default_config, index_real_name:)
    super(config: config)
    @index_real_name = index_real_name
  end

  def run
    @client.indices.create(
      index: @index_real_name,
      body: {
        settings: settings,
        mappings: mappings
      }
    )
  end

  private

  def settings
    fail NotImplementedError
  end

  def mappings
    fail NotImplementedError
  end
end
