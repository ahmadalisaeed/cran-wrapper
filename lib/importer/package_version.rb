# frozen_string_literal: true

module Importer
  class PackageVersion
    prepend SimpleCommand

    attr_reader :version

    def initialize(version)
      @version = version
    end

    def call
      description_loader_command = PackageDesciptionLoader.call(version)
      if description_loader_command.success?

        persistor_command = VersionDataPersistor.call(version, description_loader_command.result.first)

        add_error(persistor_command) unless persistor_command.success?

      else
        add_error(description_loader_command)
      end
    end

    def add_error(command)
      command.errors.keys.each do |r|
        errors.add(r, command.errors[r])
      end
    end
  end
end
