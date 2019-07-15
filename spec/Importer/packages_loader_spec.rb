# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Importer::PackagesLoader do
  subject(:context) { described_class.call }

  describe '.call' do
    context 'when the context is successful' do
      it 'succeeds' do
        expect(context).to be_success
      end

      it 'should return an array of packages' do
        expect(context.result).to be_a Array
        expect(context.result.first.keys).to eq(%w[Package Version Depends Suggests License NeedsCompilation])
      end
    end
  end
end
