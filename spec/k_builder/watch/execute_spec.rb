# frozen_string_literal: true

RSpec.describe KBuilder::Watch::Execute do
  subject { instance }

  let(:instance) { described_class.new(options) }
  let(:options) { KBuilder::Watch::CliOptions.new }

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

  context 'functional tests' do
    subject { instance.run }

    let(:options) { KBuilder::Watch::Cli.parse_options }

    before do
      ARGV.clear
      ARGV.push(*args)
    end

    # uncomment any functional test that you wish to run locally
    # context 'help' do
    #   let(:args) { ['--help'] }

    #   it { subject }
    # end

    # context 'debug' do
    #   let(:args) { ['--debug'] }

    #   it { subject }
    # end

    # context 'new_builder' do
    #   let(:args) { ['-n spec/samples/new_app'] }

    #   it { subject }
    # end

    # context 'watch' do
    #   let(:args) { ['spec/samples/new_app/.builders'] }

    #   fit { subject }
    # end
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

  # MOCKS, but not working
  # let(:instance) { described_class.new(options, actions: custom_actions) }
  # let(:run_action) { double('run_action') }
  # let(:help_action) { double('help_action') }
  # let(:debug_action) { double('debug_action') }
  # let(:new_builder_action) { double('new_builder_action') }
  # let(:custom_actions) { { help: help_action, debug: debug_action, new_builder: new_builder_action } }

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
