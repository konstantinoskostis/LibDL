require 'spec_helper'

describe LibDL::CreationOps do
  subject { described_class }

  describe '.tensor' do
    let(:data) { [ [1,2], [3,4] ] }

    it 'creates a tensor' do
      expect(subject.tensor(data)).to be_a(LibDL::Tensor)
    end

    it 'has correct shape' do
      expect(subject.tensor(data).shape).to eq([2,2])
    end

    it 'has correct data' do
      expect(subject.tensor(data).data).to eq(data)
    end
  end

  describe '.zeros' do
    let(:data) { [ [0,0], [0,0] ] }
    let(:size) { [2,2] }

    it 'creates a tensor' do
      expect(subject.zeros(*size)).to be_a(LibDL::Tensor)
    end

    it 'has correct shape' do
      expect(subject.zeros(*size).shape).to eq(size)
    end

    it 'has correct data' do
      expect(subject.zeros(*size).data).to eq(data)
    end
  end

  describe '.zeros_like' do
    let(:data) { [ [0,0], [0,0] ] }
    let(:size) { [2,2] }
    let(:t) { described_class.zeros(*size) }

    it 'creates a tensor' do
    expect(subject.zeros_like(t)).to be_a(LibDL::Tensor)
    end

    it 'has correct shape' do
      expect(subject.zeros_like(t).shape).to eq(t.shape)
    end

    it 'has correct data' do
      expect(subject.zeros_like(t).data).to eq(data)
    end
  end

  describe '.ones' do
    let(:data) { [ [1,1], [1,1] ] }
    let(:size) { [2,2] }

    it 'creates a tensor' do
      expect(subject.ones(*size)).to be_a(LibDL::Tensor)
    end

    it 'has correct shape' do
      expect(subject.ones(*size).shape).to eq(size)
    end

    it 'has correct data' do
      expect(subject.ones(*size).data).to eq(data)
    end
  end

  describe '.ones_like' do
    let(:data) { [ [1,1], [1,1] ] }
    let(:size) { [2,2] }
    let(:t) { described_class.ones(*size) }

    it 'creates a tensor' do
    expect(subject.ones_like(t)).to be_a(LibDL::Tensor)
    end

    it 'has correct shape' do
      expect(subject.ones_like(t).shape).to eq(t.shape)
    end

    it 'has correct data' do
      expect(subject.ones_like(t).data).to eq(data)
    end
  end

  describe '.arange' do
    context 'when stop is given' do
      let(:stop) { 5 }
      let(:data) { [0,1,2,3,4] }

      it 'creates a tensor' do
        expect(subject.arange(stop)).to be_a(LibDL::Tensor)
      end

      it 'has the correct data' do
        expect(subject.arange(stop).data).to eq(data)
      end
    end

    context 'when start and stop is given' do
      let(:start) { 1 }
      let(:stop) { 4 }
      let(:data) { [1,2,3] }

      it 'creates a tensor' do
        expect(subject.arange(start, stop)).to be_a(LibDL::Tensor)
      end

      it 'has the correct data' do
        expect(subject.arange(start, stop).data).to eq(data)
      end
    end

    context 'when start, stop and step is given' do
      let(:start) { 1 }
      let(:stop) { 2.5 }
      let(:step) { 0.5 }
      let(:data) { [1.0,1.5,2.0] }

      it 'creates a tensor' do
        expect(subject.arange(start, stop, step)).to be_a(LibDL::Tensor)
      end

      it 'has the correct data' do
        expect(subject.arange(start, stop, step).data).to eq(data)
      end
    end
  end

  describe '.range' do
    context 'when stop is given' do
      let(:stop) { 5 }
      let(:data) { [0,1,2,3,4,5] }

      it 'creates a tensor' do
        expect(subject.range(stop)).to be_a(LibDL::Tensor)
      end

      it 'has the correct data' do
        expect(subject.range(stop).data).to eq(data)
      end
    end

    context 'when start and stop is given' do
      let(:start) { 1 }
      let(:stop) { 4 }
      let(:data) { [1,2,3,4] }

      it 'creates a tensor' do
        expect(subject.range(start, stop)).to be_a(LibDL::Tensor)
      end

      it 'has the correct data' do
        expect(subject.range(start, stop).data).to eq(data)
      end
    end

    context 'when start, stop and step is given' do
      let(:start) { 1 }
      let(:stop) { 4 }
      let(:step) { 0.5 }
      let(:data) { [1.0,1.5,2.0,2.5,3.0,3.5,4.0] }

      it 'creates a tensor' do
        expect(subject.range(start, stop, step)).to be_a(LibDL::Tensor)
      end

      it 'has the correct data' do
        expect(subject.range(start, stop, step).data).to eq(data)
      end
    end
  end

end
