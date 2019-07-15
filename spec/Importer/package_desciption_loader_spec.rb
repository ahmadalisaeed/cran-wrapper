# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Importer::PackageDesciptionLoader do
  subject(:context) { described_class.call(version) }

  describe '.call' do
    context 'when the context is successful' do
      let(:package) { create(:package, name: 'Ac3net') }
      let(:version) { create(:version, name: '1.2.2', package: package) }

      it 'succeeds' do
        expect(context).to be_success
      end

      it 'should return description hash' do
        expect(context.result).to eq([{ 'Package' => 'Ac3net', 'Type' => 'Package', 'Title' => 'Inferring Directional Conservative Causal Core Gene Networks', 'Version' => '1.2.2', 'Date' => '2018-02-05', 'Author' => 'Gokmen Altay', 'Maintainer' => 'Gokmen Altay <altaylabs@gmail.com>', 'Description' => 'Infers directional conservative causal core (gene) networks. It is an advanced version of the algorithm C3NET by providing directional network. Gokmen Altay (2018) <doi:10.1101/271031>, bioRxiv.', 'License' => 'GPL (>= 3)', 'Depends' => 'R (>= 3.3.0), data.table', 'NeedsCompilation' => 'no', 'Encoding' => 'UTF-8', 'Packaged' => '2018-02-26 20:46:39 UTC; altay', 'Repository' => 'CRAN', 'Date/Publication' => '2018-02-26 22:08:20 UTC' }])
      end
    end

    context 'when the context is not successful' do
      let(:package) { create(:package, name: 'undefined_package_name') }
      let(:version) { create(:version, name: '99.12.32', package: package) }

      it 'fails' do
        expect(context).to be_failure
      end
    end
  end
end
