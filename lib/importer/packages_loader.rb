# frozen_string_literal: true

require 'net/http'

module Importer
  class PackagesLoader
    prepend SimpleCommand

    def call
      packages_file_data = load_packages_file
      parse_packages packages_file_data
    end

    def load_packages_file
      uri = URI('https://cran.r-project.org/src/contrib/PACKAGES')
      Net::HTTP.get(uri)
    end

    def parse_packages(packages_file_data)
      packages_file_data.split("\n\n").collect { |p| YAML.load(p) }
    end
  end
end
