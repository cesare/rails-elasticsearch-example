class EnhancedSearch::ObsoleteIndexPruner < EnhancedSearch::ElasticsearchClientBase
  def prune(base_name:)
    obsolete_index_names = find_obsolete_index_names(base_name)
    return if obsolete_index_names.empty?

    @client.indices.delete(index: obsolete_index_names)
  end

  private

  def find_obsolete_index_names(base_name)
    @client.indices.get_alias(index: "#{base_name}_*")
      .select {|name, values| values["aliases"].empty? }
      .keys
  end
end
