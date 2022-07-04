# frozen_string_literal: true

module LibDL
  # A set of operations on tensors
  module TensorOps
    include Ops
    extend self

    # Add two inputs
    #
    # @note The given inputs will be converted to tensors
    #   and then broadcasting will be applied.
    #
    # @raise LibDL::Errors::BroadcastError
    #
    # @param x [Numeric, Array, LibDL::Tensor] the first input
    # @param y [Numeric, Array, LibDL::Tensor] the second input
    # @return [LibDL::Tensor] the output tensor
    def add(x, y)
      x, y = broadcast_inputs(x, y)
      data = combine(ADD_PROC, x.data, y.data)
      Tensor.new(data)
    end

    # Subtract two inputs
    #
    # @note The given inputs will be converted to tensors
    #   and then broadcasting will be applied.
    #
    # @raise LibDL::Errors::BroadcastError
    #
    # @param x [Numeric, Array, LibDL::Tensor] the first input
    # @param y [Numeric, Array, LibDL::Tensor] the second input
    # @return [LibDL::Tensor] the output tensor
    def sub(x, y)
      x, y = broadcast_inputs(x, y)
      data = combine(SUB_PROC, x.data, y.data)
      Tensor.new(data)
    end

    # Multiply two inputs (element-wise)
    #
    # @note The given inputs will be converted to tensors
    #   and then broadcasting will be applied.
    #
    # @raise LibDL::Errors::BroadcastError
    #
    # @param x [Numeric, Array, LibDL::Tensor] the first input
    # @param y [Numeric, Array, LibDL::Tensor] the second input
    # @return [LibDL::Tensor] the output tensor
    def mul(x, y)
      x, y = broadcast_inputs(x, y)
      data = combine(MUL_PROC, x.data, y.data)
      Tensor.new(data)
    end

    # Divide two inputs (element-wise)
    #
    # @note The given inputs will be converted to tensors
    #   and then broadcasting will be applied.
    #
    # @raise LibDL::Errors::BroadcastError
    #
    # @param x [Numeric, Array, LibDL::Tensor] the first input
    # @param y [Numeric, Array, LibDL::Tensor] the second input
    # @return [LibDL::Tensor] the output tensor
    def div(x, y)
      x, y = broadcast_inputs(x, y)
      data = combine(DIV_PROC, x.data, y.data)
      Tensor.new(data)
    end

    private

    def broadcast_inputs(x, y)
      x = LibDL::Tensor.new(x) unless x.is_a?(LibDL::Tensor)
      y = LibDL::Tensor.new(y) unless y.is_a?(LibDL::Tensor)

      if x.ndim < y.ndim
        x = x.broadcast_to(y.shape)
      elsif x.ndim > y.ndim
        y = y.broadcast_to(x.shape)
      else
        # try to broadcast anyway just like numpy,
        # if the ranks of the tensors are equal
        x = x.broadcast_to(y.shape)
      end

      [x, y]
    end
  end
end
