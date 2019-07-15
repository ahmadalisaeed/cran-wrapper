# frozen_string_literal: true

class Package < ApplicationRecord
  has_many :versions
end
