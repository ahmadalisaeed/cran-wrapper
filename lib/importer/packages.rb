# frozen_string_literal: true

module Importer
  class Packages
    prepend SimpleCommand

    def call
      packages_loader_command = PackagesLoader.call
      if packages_loader_command.success?

        persistor_command = PackagesPersistor.call(packages_loader_command.result)

        add_error(persistor_command) unless persistor_command.success?

      else
        add_error(packages_loader_command)
      end
    end

    def add_error(command)
      command.errors.keys.each do |r|
        errors.add(r, command.errors[r])
      end
    end
  end
end
