# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Importer::PackageVersion do
  subject(:context) { described_class.call(version) }

  describe '.call' do
    context 'when the context is successful' do
      let(:package) { create(:package, name: 'Ac3net') }
      let(:version) { create(:version, name: '1.2.2', package: package) }

      it 'succeeds' do
        expect(context).to be_success
      end

      it 'should sync version information' do
        context
        expect(version.synced?).to eq(true)
      end
    end

    context 'when the context is not successful' do
      let(:package) { create(:package, name: 'undefined_package_name') }
      let(:version) { create(:version, name: '99.12.32', package: package) }

      it 'fails' do
        expect(context).to be_failure
      end

      it 'should not sync version information' do
        context
        expect(version.synced?).to eq(false)
      end
    end
  end
end
