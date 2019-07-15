# frozen_string_literal: true

module Importer
  class PackagesPersistor
    prepend SimpleCommand

    attr_reader :packages

    def initialize(packages)
      @packages = packages
    end

    def call
      packages.map { |package| import(package) }
    end

    def import(package_hash)
      package = find_or_create_package(package_hash['Package'])
      version = find_or_create_version(package, package_hash['Version'].to_s)
      [package.id, version.id]
    end

    def find_or_create_package(package_name)
      package = Package.find_by_name package_name
      package = Package.create(name: package_name) if package.nil?
      package
    end

    def find_or_create_version(package, version_name)
      version = package.versions.find_by_name version_name
      if version.nil?
        version = Version.create(name: version_name,
                                 package_id: package.id)
      end
      version
    end
  end
end
