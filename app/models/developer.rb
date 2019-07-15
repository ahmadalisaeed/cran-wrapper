# frozen_string_literal: true

class Developer < ApplicationRecord
  has_many :contributions, class_name: 'Contributor'
end
