class EnhancedSearch::Servant::MappingsFactory
  def create
    properties = create_properties

    {
      properties: properties,
    }
  end

  private

  def create_properties
    {
      name: {
        type: "text",
      },
      class_label: {
        type: "keyword",
      },
      rarity: {
        type: "integer",
      }
    }
  end
end
