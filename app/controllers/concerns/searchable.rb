    module Searchable
    extend ActiveSupport::Concern

    included do
        include Elasticsearch::Model
        include Elasticsearch::Model::Callbacks 

        index_name self.name.downcase.pluralize

        settings index: { number_of_shards: 1, number_of_replicas: 0 } do
        mappings dynamic: false do
        end
        end

        def as_indexed_json(options = {})
        self.as_json(
            only: self.class::SEARCHABLE_FIELDS 
        )
        end
    end
    end
