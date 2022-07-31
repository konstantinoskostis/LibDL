require 'spec_helper'

describe LibDL::Initializers::Constant do
  let(:value) { 4.0 }
  let(:shape) { [2, 3, 5] }

  subject { described_class.new(value: value) }

  describe '#call' do
    it 'creates a tensor of requested shape with given constant' do
      actual = subject.(shape)

      expect(actual).to be_a(LibDL::Tensor)
      expect(actual.shape).to eq(shape)
      expect(actual.data.flatten).to all(eq value)
    end
  end

  describe '#config' do
    let(:expected) { {value: value} }

    it 'returns the configuration' do
      actual = subject.config

      expect(actual).to eq(expected)
    end
  end
end
