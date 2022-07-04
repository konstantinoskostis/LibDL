# frozen_string_literal: true

module LibDL
  # This module represents a set of methods to create tensors.
  # It tries to follow the creation ops described in PyTorch
  # docs here: https://pytorch.org/docs/stable/torch.html#tensor-creation-ops
  module CreationOps
    extend self

    # Constructs a tensor with data
    #
    # @param data [Array] The input data
    # @return [LibDL::Tensor]
    def tensor(data)
      LibDL::Tensor.new(data)
    end

    # Returns a tensor filled with scalar value 0, with the requested shape
    #
    # @param size [Array<Integer>] The shape of the output tensor
    # @return [LibDL::Tensor]
    def zeros(*size)
      with_value(*size, 0)
    end

    # Returns a tensor filled with the scalar value 0, with the same size as input
    #
    # @param input [LibDL::Tensor] The input tensor
    # @return [LibDL::Tensor]
    def zeros_like(input)
      zeros(*input.shape)
    end

    # Returns a tensor filled with scalar value 1, with the requested shape
    #
    # @param size [Array<Integer>] The shape of the output tensor
    # @return [LibDL::Tensor]
    def ones(*size)
      with_value(*size, 1)
    end

    # Returns a tensor filled with the scalar value 1, with the same size as input
    #
    # @param input [LibDL::Tensor] The input tensor
    # @return [LibDL::Tensor]
    def ones_like(input)
      ones(*input.shape)
    end

    # Return a 1-D tensor in the [start, stop)
    #
    # @note Values in range [start, stop) are taken with common
    #   difference `step`, beginning from `start`.
    #
    # @param stop [Numeric] The last number
    # @param start [Numeric] The first number, Default: 0
    # @param step [Numeric] The step. Default: 1
    # @return [LibDL::Tensor]
    def arange(stop, start = 0, step = 1)
      stop, start = start, stop if start > stop

      length = ((stop - start) / step).ceil
      data = []

      current = start
      length.times.each do |_|
        data << current

        current += step
      end

      tensor(data)
    end

    # Return a 1-D tensor from start to stop
    #
    # @note The length of the sequence is floor(stop-start / step) + 1
    def range(stop, start = 0, step = 1)
      stop, start = start, stop if start > stop

      length = ((stop - start) / step).floor + 1

      data = []

      current = start
      length.times.each do |_|
        data << current

        current += step
      end

      tensor(data)
    end

    # Create a tensor with a given size and value
    #
    # @return [LibDL::Tensor]
    def with_value(*size, value)
      data = Array.new(size.reduce(:*)) { value }
      tensor(data).reshape(size)
    end
  end
end
