Elasticsearch::Model.client = Elasticsearch::Client.new(
  host: 'localhost:9200',
  http: {
    scheme: 'http',
    user: ENV['ELASTIC_USER'],
    password: ENV['ELASTIC_PASSWORD']
  }
)

