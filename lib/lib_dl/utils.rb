# frozen_string_literal: true

module LibDL
  # A set of utility methods
  module Utils
    extend self

    # Generate indices given a shape
    #
    # @param input_shape [Array<Integer>] The input shape
    # @return [Array<Array<Integer>]
    def generate_indices(input_shape)
      indices = input_shape.map { |dim_sz| (0...dim_sz).to_a }
      indices = indices.flatten.combination(input_shape.length).to_a.uniq

      # select only the valid indices
      indices.select! do |tuple|
        valid = [false] * tuple.length

        tuple.each_with_index do |v, idx|
          valid[idx] = (v <= input_shape[idx] - 1)
        end

        valid.uniq == [true]
      end

      indices.sort
    end
  end
end
