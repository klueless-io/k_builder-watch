# frozen_string_literal: true

RSpec.describe KBuilder::Watch do
  it 'has a version number' do
    expect(KBuilder::Watch::VERSION).not_to be nil
  end

  it 'has a standard error' do
    expect { raise KBuilder::Watch::Error, 'some message' }
      .to raise_error('some message')
  end
end
