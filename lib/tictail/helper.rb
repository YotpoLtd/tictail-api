module Tictail
  module Helper
    def convert_hash_keys(value)
      case value
        when Array
          value.map { |v| convert_hash_keys(v) }
        when Hash
          Hash[value.map { |k, v| [k.to_s, convert_hash_keys(v)] }]
        else
          value
      end
    end
  end
end