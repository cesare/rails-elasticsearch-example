class EnhancedSearch::ElasticsearchClientConfig
  def initialize
    @config = build_config
  end

  def client_parameters
    @config.deep_dup
  end

  private

  def build_config
    rails_config = Rails.application.config.elasticsearch

    {
      host: rails_config[:host],
      port: rails_config[:port],
      user: rails_config[:user],
      password: rails_config[:password],
      scheme: rails_config[:scheme],
    }
  end
end
