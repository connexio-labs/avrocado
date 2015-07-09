module Avrocado
  class Deserializer
    attr_reader :schema

    def initialize(schema)
      @schema = schema
    end

    def self.deserialize(message, schema)
      new(schema).deserialize(message)
    end

    def deserialize(message)
      Avrocado::Decoder.new(message, schema).decoded
    end
  end

  class Decoder
    attr_reader :message, :schema

    def initialize(message, schema)
      @message = message
      @schema  = schema
    end

    def decoded
      JSON.parse reader.read(nil, decoder).to_s
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
