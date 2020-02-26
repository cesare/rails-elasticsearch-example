class EnhancedSearch::BulkInserter < EnhancedSearch::ElasticsearchClientBase
  def initialize(config: default_config, index_name:)
    super(config: config)
    @index_name = index_name
  end

  def run
    target_records.find_in_batches do |records|
      body = create_bulk_insert_body(records)
      @client.bulk(body: body)
    end
  end

  private

  def target_records
    fail NotImplementedError
  end

  def create_bulk_insert_body(records)
    records.map do |record|
      create_indexing_parameters(record)
    end
  end

  def create_indexing_parameters(record)
    document = create_index_document(record)
    {
      index: {
        _index: @index_name,
        _id: record.id,
        data: document,
      }
    }
  end

  def create_index_document(servant)
    fail NotImplementedError
  end
end
