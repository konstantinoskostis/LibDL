# frozen_string_literal: true

module LibDL
  # This module offers reshaping functionality to tensors
  module Reshapeable
    # Reshape tensor to the new shape
    #
    # @param new_shape [Array<Integer>]
    # @return [LibDL::Tensor] the reshaped tensor
    def reshape(new_shape)
      new_elements_size = new_shape.reduce(&:*)
      elements_size = shape.reduce(&:*)

      if new_elements_size != elements_size
        args = [elements_size, new_shape]
        raise LibDL::Errors::ReshapeError.new(*args)
      end

      new_data = data.dup.flatten

      new_shape.reverse.each do |new_dim_sz|
        new_data = new_data.each_slice(new_dim_sz).to_a
      end

      new_data = new_data.first

      Tensor.new(new_data)
    end
    alias view reshape
  end
end
