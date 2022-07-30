require 'spec_helper'

describe LibDL::Parameter do
  describe '#initialize' do
    let(:input) do
      [
        [1,2,3],
        [4,5,6]
      ]
    end

    let(:grad) do
      [
        [0, 0, 0],
        [0, 0, 0]
      ]
    end

    subject { described_class.new(input) }

    it 'sets the data tensor' do
      expect(subject.data).to be_a(LibDL::Tensor)
      expect(subject.data.data).to eq(input)
    end

    it 'sets the grad tensor' do
      expect(subject.grad).to be_a(LibDL::Tensor)
      expect(subject.grad.data).to eq(grad)
    end
  end
end
