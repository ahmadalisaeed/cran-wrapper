# frozen_string_literal: true

require 'mail'

module Importer
  class VersionDataPersistor
    prepend SimpleCommand

    attr_reader :version, :description

    def initialize(version, description)
      @version = version
      @description = description
    end

    def call
      extract_and_save_information
      extract_and_save_contributors
    end

    def extract_and_save_information
      version.title = description['Title']
      version.publication = description['Date']
      version.description = description['Description']
      version.status = Version.statuses[:synced]
      version.save
    end

    def extract_and_save_contributors
      %w[Maintainer Author].each do |contributor_type|
        parse_and_save_contributor(contributor_type, description[contributor_type])
      end
    end

    def parse_and_save_contributor(type, infos)
      infos.split(', ').each do |info|
        mail_adress = Mail::Address.new(info)

        developer = Developer.create_with(name: mail_adress.display_name).find_or_create_by(email: mail_adress.address)

        type.constantize.find_or_create_by(developer_id: developer.id, version_id: version.id)
      end
    rescue Mail::Field::IncompleteParseError => e
      # errors.add(e.class.name, e.message )
    end
  end
end
