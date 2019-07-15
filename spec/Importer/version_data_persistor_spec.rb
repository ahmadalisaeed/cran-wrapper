# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Importer::VersionDataPersistor do
  subject(:context) { described_class.call(version, description) }

  describe '.call' do
    context 'when the context is successful' do
      let(:package) { create(:package, name: 'abd') }
      let(:version) { create(:version, name: '0.2-8', package: package) }
      let(:description) { { 'Package' => 'abd', 'Type' => 'Package', 'Title' => 'The Analysis of Biological Data', 'Version' => '0.2-8', 'Date' => '2015-07-02', 'Author' => 'Kevin M. Middleton <middletonk@missouri.edu>, Randall Pruim <rpruim@calvin.edu>', 'Maintainer' => 'Kevin M. Middleton <middletonk@missouri.edu>', 'Depends' => 'R (>= 3.0), nlme, lattice, grid, mosaic', 'Suggests' => 'boot, car, ggplot2, plyr, HH, ICC, vcd, Hmisc', 'Description' => 'The abd package contains data sets and sample code for The Analysis of Biological Data by Michael Whitlock and Dolph Schluter (2009; Roberts & Company Publishers).', 'License' => 'GPL-2', 'LazyLoad' => 'yes', 'LazyData' => 'yes', 'Encoding' => 'UTF-8', 'Collate' => "'abdData.R' 'histochart.R' 'datasets.R' 'themes.R'", 'NeedsCompilation' => 'no', 'Packaged' => '2015-07-03 01:35:03 UTC; kmm', 'Repository' => 'CRAN', 'Date/Publication' => '2015-07-03 05:44:45' } }

      it 'succeeds' do
        expect(context).to be_success
      end

      it 'should persist version data' do
        context

        expect(version.title).to eq(description['Title'])
        expect(version.publication).to eq(Date.parse(description['Date']))
        expect(version.description).to eq(description['Description'])

        expect(version.authors.map(&:mail_address).join(', ')).to eq(description['Author'])
        expect(version.maintainers.map(&:mail_address).join(', ')).to eq(description['Maintainer'])

        expect(version.synced?).to eq(true)
      end
    end
  end
end
