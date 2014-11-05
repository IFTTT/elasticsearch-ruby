module Elasticsearch
  module API
    module Actions


      # This is a monkey patch to enable us to load preference data to the "Taste" plugin
      def taste_event(arguments={})
        raise ArgumentError, "Required argument 'index' missing" unless arguments[:index]

        valid_params = [
          :consistency,
          :op_type,
          :parent,
          :percolate,
          :refresh,
          :replication,
          :routing,
          :timeout,
          :timestamp,
          :ttl,
          :version,
          :version_type ]

        method = arguments[:id] ? 'PUT' : 'POST'
        path   = Utils.__pathify Utils.__escape(arguments[:index]),
                                 Utils.__escape('_taste'),
                                 Utils.__escape('event')

        params = Utils.__validate_and_extract_params arguments, valid_params
        body   = arguments[:body]

        perform_request(method, path, params, body).body
      end
    end
  end
end
