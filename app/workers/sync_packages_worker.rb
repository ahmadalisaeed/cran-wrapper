# frozen_string_literal: true

class SyncPackagesWorker
  include Sidekiq::Worker

  def perform
    commad = Importer::Packages.call
  end
end
