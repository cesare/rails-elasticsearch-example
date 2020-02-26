class EnhancedSearch::Servant::IndexEntity < EnhancedSearch::IndexEntity
  attr_reader :servant

  def initialize(servant:)
    @servant = servant
  end

  def identifier
    servant.id
  end

  def create_index_document
    {
      name: servant.name,
      class_label: servant.class_label,
      rarity: servant.rarity,
    }
  end
end
