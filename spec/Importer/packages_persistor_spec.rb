# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Importer::PackagesPersistor do
  subject(:context) { described_class.call(package_hashes_array) }

  describe '.call' do
    context 'when the context is successful' do
      let(:package_hashes_array) do
        [{ 'Package' => 'A3', 'Version' => '1.0.0', 'Depends' => 'R (>= 2.15.0), xtable, pbapply', 'Suggests' => 'randomForest, e1071', 'License' => 'GPL (>= 2)', 'NeedsCompilation' => false },
         { 'Package' => 'abbyyR', 'Version' => '0.5.5', 'Depends' => 'R (>= 3.2.0)', 'Imports' => 'httr, XML, curl, readr, plyr, progress', 'Suggests' => 'testthat, rmarkdown, knitr (>= 1.11), lintr', 'License' => 'MIT + file LICENSE', 'NeedsCompilation' => false },
         { 'Package' => 'abc', 'Version' => '2.1', 'Depends' => 'R (>= 2.10), abc.data, nnet, quantreg, MASS, locfit', 'License' => 'GPL (>= 3)', 'NeedsCompilation' => false }].freeze
      end

      it 'succeeds' do
        expect(context).to be_success
      end

      it 'should sync version information' do
        result = context.result
        expect(result.count).to eq(3)
        expect(Package.count).to eq(3)
        expect(Version.count).to eq(3)
      end
    end
  end
end
