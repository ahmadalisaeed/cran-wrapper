# frozen_string_literal: true

require 'dcf'
module Importer
  class PackageDesciptionLoader
    prepend SimpleCommand

    attr_reader :package, :version, :description

    def initialize(version)
      @version = version
      @package = version.package
    end

    def call
      create_folder
      download_package
      unzip_package
      load_description
      delete_folder
      parse_desciption
    end

    def download_package
      `wget --content-disposition -q #{package_url} -O #{package_folder}/#{file_name}.tar.gz`
    end

    def package_url
      "https://cran.r-project.org/src/contrib/#{file_name}.tar.gz"
    end

    def package_folder
      "#{ENV['PACKAGES_DIR']}/#{file_name}"
    end

    def file_name
      "#{package.name}_#{version.name}"
    end

    def create_folder
      FileUtils.mkdir(package_folder)
    end

    def delete_folder
      FileUtils.remove_dir(package_folder)
    end

    def unzip_package
      `tar xvzf #{package_folder}/#{file_name}.tar.gz -C #{package_folder}/`
    end

    def load_description
      if Dir["#{package_folder}/#{package.name}/DESCRIPTION"].any?
        @description ||= File.new("#{package_folder}/#{package.name}/DESCRIPTION").read
      else
        errors.add(:No_Description_File, 'No File ')
      end
    end

    def parse_desciption
      Dcf.parse description if description
    end
  end
end
