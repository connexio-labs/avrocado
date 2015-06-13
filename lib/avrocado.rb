require 'java'
require 'json'
require 'vendor/java/jackson-core-asl'
require 'vendor/java/jackson-mapper-asl'
require 'vendor/java/avro'
require 'avrocado/version'

module Java
  module Avro
    include_package 'org.apache.avro'
    include_package 'org.apache.avro.generic'
  end
end

module Avrocado
  EXAMPLE_SCHEMA_PATH='./config/example-schema.avsc'

  include_package 'org.apache.avro.io'

  class Schema
    def self.parse(path = EXAMPLE_SCHEMA_PATH)
      Java::Avro::Schema::Parser.new.parse(java.io.File.new(path))
    end
  end

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
