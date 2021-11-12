# FIXME: Fix the ca_fingerprint
# https://github.com/elastic/elasticsearch-ruby/pull/1474
# Or pass `{ ssl: { verify: false } }
Elasticsearch::Model.client = Elasticsearch::Client.new(
  hosts: 'localhost:9200',
  http: {
    scheme: 'https',
    user: ENV['ELASTIC_USER'],
    password: ENV['ELASTIC_PASSWORD']
  },
  transport_options: { ssl: { verify: true } },
  ca_fingerprint: 'SOMETHING_HERE'
)

