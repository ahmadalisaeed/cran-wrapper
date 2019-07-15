# frozen_string_literal: true

class Version < ApplicationRecord
  enum status: %i[ready synced]

  belongs_to :package
  has_many :contributors
  has_many :maintainers
  has_many :authors
end
