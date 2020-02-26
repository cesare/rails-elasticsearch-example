class EnhancedSearch::BulkIndexBuilder
  def initialize(event_publishing_channel: default_event_publishing_channel)
    @event_publishing_channel = event_publishing_channel
    @index_real_name = create_index_real_name
  end

  def run
    generate_index
    bulk_insert
    change_aliases
  end

  private

  attr_reader :event_publishing_channel, :index_real_name

  def default_event_publishing_channel
  end

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

  def index_generator_class
    fail NotImplementedError
  end

  def create_index_generator
    index_generator_class.new(index_real_name: index_real_name)
  end

  def generate_index
    index_generator = create_index_generator
    index_generator.run
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
