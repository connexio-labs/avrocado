module Avrocado
  class Serializer
    attr_reader :message, :schema

    def initialize(message, schema = Schema.parse)
      @message = message
      @schema  = schema
    end

    def self.serialize(message)
      new(message).serialize
    end

    def serialize
      message.each do |field, value|
        record.put(field.to_s, value)
      end

      writer.write(record, encoder)

      encoder.flush

      output.to_byte_array
    end

    private

    def record
      @record ||= Java::Avro::GenericData::Record.new(Avrocado::Schema.parse)
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
