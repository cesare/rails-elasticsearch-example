class EnhancedSearch::IndexGenerator < EnhancedSearch::ElasticsearchClientBase
  def run(index_name:, settings:, mappings:)
    @client.indices.create(
      index: index_name,
      body: {
        settings: settings,
        mappings: mappings
      }
    )
  end
end
