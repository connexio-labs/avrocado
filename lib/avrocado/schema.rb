module Avrocado
  EXAMPLE_SCHEMA_PATH = './config/example-schema.avsc'

  class Schema
    def self.parse(path = EXAMPLE_SCHEMA_PATH)
      Java::Avro::Schema::Parser.new.parse(java.io.File.new(path))
    end
  end
end
