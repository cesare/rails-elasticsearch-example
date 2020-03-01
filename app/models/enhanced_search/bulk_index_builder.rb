class EnhancedSearch::BulkIndexBuilder
  def initialize
    @index_real_name = create_index_real_name
  end

  def run
    generate_index
    bulk_insert
    change_aliases
  end

  private

  attr_reader :index_real_name

  def index_base_name
    fail NotImplementedError
  end

  def create_index_real_name
    suffix = create_version_suffix
    "#{index_base_name}_#{suffix}"
  end

  def create_version_suffix
    Time.current.strftime("%Y%m%d_%H%M%S")
  end

  def create_index_generator
    EnhancedSearch::IndexGenerator.new
  end

  def index_settings
    fail NotImplementedError
  end

  def index_mappings
    fail NotImplementedError
  end

  def generate_index
    index_generator = create_index_generator
    index_generator.run(
      index_name: index_real_name,
      settings: index_settings,
      mappings: index_mappings
    )
  end

  def targets
    fail NotImplementedError
  end

  def create_bulk_entity_indexer
    EnhancedSearch::BulkEntityIndexer.new(index_name: index_real_name)
  end

  def bulk_insert
    indexer = create_bulk_entity_indexer
    targets.each_batch do |entities|
      indexer.index(entities: entities)
    end
  end

  def create_alias_changer
    EnhancedSearch::AliasChanger.new(
      index_base_name: index_base_name,
      index_real_name: index_real_name
    )
  end

  def change_aliases
    alias_changer = create_alias_changer
    alias_changer.run
  end
end
