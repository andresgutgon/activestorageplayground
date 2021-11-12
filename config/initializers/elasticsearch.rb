# FIXME: Fix the ca_fingerprint
# https://github.com/elastic/elasticsearch-ruby/pull/1474
# Or pass `{ ssl: { verify: false } }
ca_file_path = Rails.root.join('docker/elasticsearch-ssl-certificate/certs/ca/ca.crt')
Elasticsearch::Model.client = Elasticsearch::Client.new(
  hosts: 'localhost:9200',
  http: {
    scheme: 'https',
    user: ENV['ELASTIC_USER'],
    password: ENV['ELASTIC_PASSWORD']
  },
  transport_options: {
    ssl: {
      verify: true,
      ca_file: ca_file_path.to_s
    }
  }
)

