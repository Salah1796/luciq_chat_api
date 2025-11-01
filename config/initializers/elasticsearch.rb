require 'elasticsearch'

Elasticsearch::Model.client = Elasticsearch::Client.new(
  host: ENV.fetch('ELASTICSEARCH_HOST') { 'http://localhost:9200' },
  log: true
)

if Rails.env.development? || Rails.env.production?
  begin
    Message.__elasticsearch__.create_index! force: true
    Message.import
  rescue => e
    Rails.logger.warn "Elasticsearch setup failed: #{e.message}"
  end
end