module Avrocado
  class Deserializer
    attr_reader :schema, :message

    def initialize(message, schema = Schema.parse)
      @message = message
      @schema  = schema
    end

    def self.deserialize(message)
      new(message).deserialize
    end

    def deserialize
      JSON.parse(reader.read(nil, decoder).to_s)
    end

    private

    def reader
      @reader ||= Java::Avro::GenericDatumReader.new(schema)
    end

    def decoder
      @decoder ||= Avrocado::DecoderFactory
        .default_factory
        .create_binary_decoder(message, nil)
    end
  end
end
