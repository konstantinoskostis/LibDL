# frozen_string_literal: true

require 'lib_dl/core/broadcastable'
require 'lib_dl/core/reshapeable'

module LibDL
  # A tensor is the fundamental container of numerical data
  class Tensor
    include Reshapeable
    include Broadcastable

    attr_reader :data, :shape, :strides

    def initialize(data)
      if data.nil? || (data.is_a?(Array) && data.empty?)
        raise ArgumentError,
              "Expected an array with values or a scalar. Got #{data}"
      end

      @data = data
      calculate_shape_and_stride(data)
    end

    # Fetch the number of dimensions of the tensor
    #
    # @return [Array<Integer>]
    def dim
      shape.length
    end
    alias ndim dim

    # Check if tensor is a scalar
    #
    # @return [Boolean] true if tensor is scalar, false otherwise
    def scalar?
      ndim.zero?
    end

    # Check if the tensor is a vector
    #
    # @return [Boolean] true if tensor is one dimensional, false otherwise
    def vector?
      ndim == 1
    end

    # Check if the tensor is a matrix
    #
    # @return [Boolean] true if tensor is a two dimensional, false otherwise
    def matrix?
      ndim == 2
    end

    # Add the given value to the current tensor
    def +(other)
      LibDL::TensorOps.add(self, other)
    end

    # Subtract the given value from the current tensor
    def -(other)
      LibDL::TensorOps.sub(self, other)
    end

    # Multiply the given value with the current tensor
    #
    # @note This performs an element-wise multiplication
    def *(other)
      LibDL::TensorOps.mul(self, other)
    end

    # Divide current tensor with the given value
    #
    # @note This performs an element-wise division
    def /(other)
      LibDL::TensorOps.div(self, other)
    end

    # Perfrom type coercion
    #
    # @note this handles cases where numeric values are on the
    #   left hand side.
    def coerce(other)
      [self.class.new(other), self]
    end

    private

    # Calculate the shape and strides of input data
    def calculate_shape_and_stride(input_data)
      data_shape = calculate_shape(input_data)
      calculate_stride(data_shape)
    end

    # Calculate the shape of a multi-dimensional array
    def calculate_shape(input_data)
      if input_data.is_a?(Numeric)
        @shape = []
        return @shape
      end

      data_shape = []
      running = true

      while running
        running = input_data.is_a?(Array)
        break unless running

        data_shape << input_data.length
        input_data = input_data[0]
      end

      @shape = data_shape
    end

    # Calculate the strides given a shape
    #
    # @param input_shape [Array<Integer>] The input shape
    # @return [Array<Integer>] The calculated strides
    def calculate_stride(input_shape)
      if input_shape.empty?
        @strides = []
        return @strides
      end

      strides = []
      sh = input_shape.dup

      while sh.length.positive?
        sh.shift
        strides << sh.reduce(&:*)
      end

      strides[-1] = 1

      @strides = strides
    end
  end
end
