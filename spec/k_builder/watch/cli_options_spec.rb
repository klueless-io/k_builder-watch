# frozen_string_literal: true

RSpec.describe KBuilder::Watch::CliOptions do
  subject { instance }

  let(:instance) { described_class.new }

  let(:base_expected) do
    {
      debug: false,
      help: false,
      base_path: Dir.pwd,
      watch_path_arg: nil,
      watch_path: nil,
      new_arg: nil,
      new_app_path: nil,
      new_watch_path: nil
    }
  end

  describe 'initialize' do
    it do
      is_expected
        .to have_attributes(base_expected)
        .and have_attributes(debug?: false)
        .and have_attributes(help?: false)
        .and have_attributes(new?: false)
    end
  end

  describe '#to_h' do
    subject { instance.to_h }

    it { is_expected.to include(base_expected) }
  end
end
