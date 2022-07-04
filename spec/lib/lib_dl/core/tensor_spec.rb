require 'spec_helper'

describe LibDL::Tensor do
  let(:data) { [[1,2,3], [4,5,6]] }
  subject { described_class.new(data) }

  describe 'errors during #initialize' do
    let(:data) { [] }

    it 'raises an error when an empty array is given' do
      expect do
        described_class.new(data)
      end.to raise_error(ArgumentError)
    end
  end

  describe '#initialize & attributes' do
    it 'sets data' do
      expect(subject.data).to eq(data)
    end

    it 'sets shape' do
      expect(subject.shape).to eq([2, 3])
    end

    it 'sets strides' do
      expect(subject.strides).to eq([3,1])
    end
  end

  describe '#dim' do
    it 'has dimensions' do
      expect(subject.dim).to eq(2)
    end

    it 'responds with correct value to alias #ndim' do
      expect(subject.ndim).to eq(2)
    end
  end

  describe '#scalar?' do
    context 'when a single number' do
      let(:data) { 5 }

      it 'return true' do
        expect(subject.scalar?).to be_truthy
      end
    end

    context 'when not a single number' do
      it 'returns false' do
        expect(subject.scalar?).to be_falsey
      end
    end
  end

  describe '#vector?' do
    context 'when a 1D array' do
      let(:data) { [1,2,3] }

      it 'return true' do
        expect(subject.vector?).to be_truthy
      end
    end

    context 'when not a 1D array' do
      it 'returns false' do
        expect(subject.scalar?).to be_falsey
      end
    end
  end

  describe '#matrix?' do
    context 'when a 2D array' do
      it 'return true' do
        expect(subject.matrix?).to be_truthy
      end
    end

    context 'when not a 2D array' do
      let(:data) { [1,2,3] }

      it 'returns false' do
        expect(subject.matrix?).to be_falsey
      end
    end
  end
end
