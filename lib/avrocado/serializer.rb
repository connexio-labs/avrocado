module Avrocado
  class Serializer
    attr_reader :schema

    def initialize(schema)
      @schema = schema
    end

    def self.serialize(message, schema)
      new(schema).serialize(message)
    end

    def serialize(message)
      Avrocado::Encoder.new(message, schema).encoded
    end
  end

  class Encoder
    attr_reader :message, :schema

    def initialize(message, schema)
      @message = message
      @schema  = schema
    end

    def encoded
      message.each { |field, value| record.put(field.to_s, value) }

      writer.write(record, encoder)

      encoder.flush

      output.to_byte_array
    end

    private

    # TODO: explore whether we can reuse the Java-based objects below
    #       if so, we can reuse an instance of a Serializer

    def record
      @record ||= Java::Avro::GenericData::Record.new(schema)
    end

    def output
      @output ||= java.io.ByteArrayOutputStream.new
    end

    def encoder
      @encoder ||= Avrocado::EncoderFactory.new.binary_encoder(output, nil)
    end

    def writer
      @writer ||= Java::Avro::GenericDatumWriter.new(schema)
    end
  end
end
