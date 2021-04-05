# frozen_string_literal: true

RSpec.describe KBuilder::Watch::Cli do
  subject { instance }

  let(:instance) { described_class.new }

  before do
    ARGV.clear
    ARGV.push(*args)
  end

  let(:args) { [] }
  let(:base_expected) do
    {
      debug: false,
      help: false,
      base_path: Dir.pwd,
      watch_path_arg: '.',
      watch_path: Dir.pwd,
      new_arg: nil,
      new_app_path: nil,
      new_watch_path: nil
    }
  end

  context '.help?' do
    it { is_expected.not_to be_help }

    context 'when turned on' do
      let(:args) { ['-h'] }
      it { is_expected.to be_help }
    end
  end

  context '.debug' do
    it { is_expected.not_to be_debug }

    context 'when turned on' do
      let(:args) { ['--debug'] }
      it { is_expected.to be_debug }
    end
  end

  describe '#to_h' do
    subject { instance.to_h }

    context 'when no paramaters' do
      it { is_expected.to include(base_expected) }
    end

    context 'when (watch_path_arg) DIR argument supplied' do
      context 'with no argument' do
        let(:args) { [] }

        it do
          expected = base_expected.merge({
                                           base_path: Dir.pwd,
                                           watch_path: Dir.pwd,
                                           watch_path_arg: '.'
                                         })
          is_expected.to include(expected)
        end
      end
      context 'with relative path' do
        let(:args) { ['.builders'] }

        it {
          expected = base_expected.merge({
                                           base_path: Dir.pwd,
                                           watch_path: File.join(Dir.pwd, '.builders'),
                                           watch_path_arg: '.builders'
                                         })
          is_expected.to include(expected)
        }
      end
      context 'with home path' do
        let(:args) { ['~/xmen/.builders'] }

        it do
          expected = base_expected.merge({
                                           base_path: Dir.pwd,
                                           watch_path: File.expand_path('~/xmen/.builders'),
                                           watch_path_arg: '~/xmen/.builders'
                                         })
          is_expected.to include(expected)
        end
      end
      context 'with absolute path' do
        let(:args) { ['/xmen/.builders'] }

        # KLog.logger.visual_compare_hashes(expected, subject)
        it do
          expected = base_expected.merge({
                                           base_path: Dir.pwd,
                                           watch_path: '/xmen/.builders',
                                           watch_path_arg: '/xmen/.builders'
                                         })
          is_expected.to include(expected)
        end
      end
    end

    context 'when (new_arg) --new argument supplied' do
      context 'without application name' do
        let(:args) { ['-n'] }

        it do
          expected = base_expected.merge({
                                           watch_path: File.join(Dir.pwd, '.builders'),
                                           new_arg: '',
                                           new_app_path: Dir.pwd,
                                           new_watch_path: File.join(Dir.pwd, '.builders')
                                         })
          # KLog.logger.visual_compare_hashes subject, expected
          is_expected.to include(expected)
        end
      end
      context 'with application name' do
        let(:args) { ['-n KafeOwner'] }

        it {
          expected = base_expected.merge({
                                           new_arg: 'KafeOwner',
                                           new_app_path: File.join(Dir.pwd, 'KafeOwner'),
                                           new_watch_path: File.join(Dir.pwd, 'KafeOwner', '.builders'),
                                           watch_path: File.join(Dir.pwd, 'KafeOwner', '.builders')
                                         })
          is_expected.to include(expected)
        }
      end
    end
  end
end
