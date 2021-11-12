require 'elasticsearch/model'

class Article < ApplicationRecord
  include Searchable
end
