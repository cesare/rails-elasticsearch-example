class EnhancedSearch::Servant::IndexGenerator < EnhancedSearch::IndexGenerator
  private

  def settings
    EnhancedSearch::Servant::SettingsFactory.new.create
  end

  def mappings
    EnhancedSearch::Servant::MappingsFactory.new.create
  end
end
