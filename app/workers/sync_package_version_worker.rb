# frozen_string_literal: true

class SyncPackageVersionWorker
  include Sidekiq::Worker

  def perform(version_id)
    version = Version.find version_id
    commad = Importer::PackageVersion.call(version)
    # TODO: Error handling
  end
end
