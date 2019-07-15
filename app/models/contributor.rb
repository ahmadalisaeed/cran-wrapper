# frozen_string_literal: true

class Contributor < ApplicationRecord
  belongs_to :developer
  belongs_to :version

  def mail_address
    "#{developer.name} <#{developer.email}>"
  end
end
