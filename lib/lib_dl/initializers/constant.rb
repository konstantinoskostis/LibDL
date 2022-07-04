# frozen_string_literal: true

module LibDL
  # This module represents initializers used for initializing
  # tensors/parameters/weights.
  module Initializers
    # This class generates tensors with constant values.
    class Constant < Base
      def initialize(value: 0)
        super()
        @value = value
      end

      def call(shape, _kwargs = {})
        LibDL::CreationOps.with_value(*shape, @value)
      end

      def config
        { value: @value }
      end
    end
  end
end
