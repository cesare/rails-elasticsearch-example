class EnhancedSearch::AliasChanger < EnhancedSearch::ElasticsearchClientBase
  def initialize(config: default_config, index_base_name:, index_real_name:)
    super(config: config)
    @index_base_name = index_base_name
    @index_real_name = index_real_name
  end

  def run
    actions = create_actions
    @client.indices.update_aliases(body: { actions: actions })
  end

  private

  def alias_exists?
    @client.indices.exists_alias?(name: @index_base_name)
  end

  def find_existing_aliases
    unless alias_exists?
      return []
    end

    @client.indices.get_alias(name: @index_base_name).map do |index_name, _aliases|
      {
        index: index_name,
        alias: @index_base_name,
      }
    end
  end

  def create_actions
    old_aliases = find_existing_aliases
    removal_actions = create_removal_actions(old_aliases: old_aliases)
    addition_action = create_addition_action

    actions = []
    actions += removal_actions
    actions << addition_action

    actions
  end

  def create_removal_actions(old_aliases:)
    old_aliases.map do |old_alias|
      { remove: old_alias }
    end
  end

  def create_addition_action
    {
      add: {
        index: @index_real_name,
        alias: @index_base_name,
      }
    }
  end
end
