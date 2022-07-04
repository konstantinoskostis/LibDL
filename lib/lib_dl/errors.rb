# frozen_string_literal: true

module LibDL
  # A set of error classes that are used in the library.
  # The stringified errors match (as close as possible) numpy's.
  module Errors
    class Error < StandardError; end

    # An error class used when reshaping
    class ReshapeError < Error
      def initialize(size, shape)
        msg = "cannot reshape array of size #{size} into shape #{shape}"
        super(msg)
      end
    end

    # An error class used when broadcasting
    class BroadcastError < Error
      def initialize(lhs_shape, rhs_shape)
        msg = 'operands could not be broadcast together with shapes ' \
              "#{lhs_shape} and #{rhs_shape}"
        super(msg)
      end
    end
  end
end
