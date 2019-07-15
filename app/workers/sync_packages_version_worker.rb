# frozen_string_literal: true

class SyncPackagesVersionWorker
  include Sidekiq::Worker

  def perform
    Version.ready.limit(20).pluck(:id).each do |version_id|
      SyncPackageVersionWorker.perform_async(version_id)
    end
  end
end
