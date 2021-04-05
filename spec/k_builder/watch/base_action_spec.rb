# frozen_string_literal: true

RSpec.describe KBuilder::Watch::BaseAction do
  subject { instance }

  let(:instance) { described_class.new(options) }
  let(:options) { KBuilder::Watch::CliOptions.new }

  describe 'initialize' do
    it { is_expected.not_to be_nil }
  end

  describe '#run' do
    subject { instance.run }

    it { expect { subject }.to raise_error(KBuilder::Watch::Error, 'Descendants of BaseAction must implement the run method') }
  end
end
