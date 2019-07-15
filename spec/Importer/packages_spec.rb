# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Importer::Packages do
  subject(:context) { described_class.call }

  describe '.call' do
    context 'when the context is successful' do
      it 'succeeds' do
        expect(context).to be_success
      end
    end
  end
end
