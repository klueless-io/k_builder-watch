# frozen_string_literal: true

RSpec.describe KBuilder::Watch::Execute do
  subject { instance }

  let(:instance) { described_class.new(options) }
  let(:options) { KBuilder::Watch::CliOptions.new }

  # let(:instance) { described_class.new(options, actions: custom_actions) }
  # let(:run_action) { double('run_action') }
  # let(:help_action) { double('help_action') }
  # let(:debug_action) { double('debug_action') }
  # let(:new_builder_action) { double('new_builder_action') }
  # let(:custom_actions) { { help: help_action, debug: debug_action, new_builder: new_builder_action } }

  describe 'initialize' do
    it { is_expected.not_to be_nil }
  end

  describe '#run_action' do
    subject { instance.run_action(action_key) }

    context 'unknown' do
      let(:action_key) { :unknown }

      it { expect { subject }.to raise_error(KBuilder::Watch::Error, "Unknown action: #{action_key}") }
    end
  end

  # describe '#run' do
  #   subject { instance.run }

  #   context 'help' do
  #     before { options.help = true }

  #     fit {
  #       run = double('run')
  #       run_action = double('run_action')

  #       allow(run).to receive(run_action)
  #       allow(run_action).to receive(:new).with(options)

  #       subject
  #       # expect(help_action).to receive(:run) #.with("ruby.jpg")
  #     }
  #   end
  # end
end
