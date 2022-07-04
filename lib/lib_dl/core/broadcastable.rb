# frozen_string_literal: true

require 'lib_dl/utils'

module LibDL
  # This module offers broadcasting capability to tensors.
  module Broadcastable
    # Broadcast tensor to the given shape
    #
    # @raise LibDL::Errors::BroadcastError
    #
    # @param new_shape [Array<Integer>] The new shape for broadcasting
    # @return [LibDL::Tensor] The broadcasted tensor
    def broadcast_to(new_shape)
      if broadcastable_to?(new_shape)
        perform_broadcasting_to(new_shape)
      else
        raise LibDL::Errors::BroadcastError.new(shape, new_shape)
      end
    end

    # Check if the tensor can be broadcasted to the given shape
    #
    # The method uses Numpy's broadcasting rules. For more information refer to
    # - https://numpy.org/doc/stable/user/basics.broadcasting.html
    # - https://numpy.org/devdocs/user/theory.broadcasting.html
    #
    # @param new_shape [Array<Integer>] The given shape into which the tensor
    #   is tested against.
    # @return [Boolean] true if the tensor can be broadcasted to the given shape,
    #   false otherwise.
    def broadcastable_to?(new_shape)
      return false if shape.length > new_shape.length

      broadcastable = true

      from_shape = shape.dup

      # Prepend, if needed the necessary number of 1
      if from_shape.length < new_shape.length
        diff = new_shape.length - from_shape.length
        from_shape = Array.new(diff) { 1 } + from_shape
      end

      zipped = new_shape.reverse.zip(from_shape.reverse)

      zipped.each do |dim1, dim2|
        equal = (dim1 == dim2)
        either_one = (dim1 == 1 || dim2 == 1)

        broadcastable = false if !equal && !either_one
        break unless broadcastable
      end

      broadcastable
    end

    private

    # Perform the actual broadcasting to the new shape
    def perform_broadcasting_to(new_shape)
      new_strides = [0] * new_shape.length
      diff = new_shape.length - dim

      (0...dim).to_a.each do |d|
        new_strides[diff + d] = strides[d] if shape[d] > 1
      end

      container = scalar? ? [data] : data
      storage = container.dup.flatten
      new_storage = []

      indices = LibDL::Utils.generate_indices(new_shape)

      # map the values of the current data-container to the new container, in 1D (vector) space
      indices.each do |tuple|
        pos = 0

        tuple.each_with_index do |v, idx|
          pos += (v * new_strides[idx])
        end

        new_storage << storage[pos]
      end

      # perform a reshape
      LibDL::Tensor.new(new_storage).reshape(new_shape)
    end
  end
end
