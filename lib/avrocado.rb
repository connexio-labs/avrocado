require 'java'
require 'json'
require_relative '../vendor/java/jackson-core-asl'
require_relative '../vendor/java/jackson-mapper-asl'
require_relative '../vendor/java/avro'

require 'avrocado/schema'
require 'avrocado/serializer'
require 'avrocado/deserializer'
require 'avrocado/version'

module Java
  module Avro
    include_package 'org.apache.avro'
    include_package 'org.apache.avro.generic'
  end
end

module Avrocado
  include_package 'org.apache.avro.io'
end
