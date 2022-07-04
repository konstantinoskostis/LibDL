# frozen_string_literal: true

module LibDL
  # A set of generic operations (unary and binary) on arrays
  module Ops
    extend self

    # Unary operations
    NEG_PROC = proc { |a| -a }.freeze
    LOG_PROC = proc { |a| Math.log(a) }.freeze
    EXP_PROC = proc { |a| Math.exp(a) }.freeze

    LOG10_PROC = proc { |a| Math.log10(a) }.freeze
    LOG2_PROC  = proc { |a| Math.log2(a) }.freeze

    SIGM_PROC = proc { |a| 1 / (1 + Math.exp(a)) }.freeze
    TANH_PROC = proc { |a| Math.tanh(a) }.freeze
    RELU_PROC = proc { |a| a.positive? ? a : 0 }.freeze

    # Binary operations
    ADD_PROC = proc { |a, b| a + b }.freeze
    SUB_PROC = proc { |a, b| a - b }.freeze
    MUL_PROC = proc { |a, b| a * b }.freeze
    DIV_PROC = proc { |a, b| a / b.to_f }.freeze
    POW_PROC = proc { |a, b| a**b }.freeze

    # Apply a function to a multi-dimensional array
    #
    # @note This method should be used for applying unary operations on
    #   a multi-dimensional array. E.g log(x), abs(x), etc
    #
    # @param func [Proc] The function to apply
    # @param data [Array] The multi-dimensional array
    # @return [Array] The transformed array
    def apply(func, data)
      if data[0].is_a?(Numeric)
        data.map { |e| func.call(e) }
      else
        data.map { |d| apply(func, d) }
      end
    end

    # Combine two multi-dimensional arrays and perform a function element-wise
    #
    # @note Assumes that t1 and t2 have the same shape!
    #
    # @param func [Proc] The function to be applied
    # @param t1 [Array] The first multi-dimensional array
    # @param t2 [Array] The second multidimensional array
    # @return [Array] The new array as a combination of the given two arrays
    def combine(func, t1, t2)
      if t1[0].is_a?(Numeric)
        t1.zip(t2).map { |a, b| func.call(a, b) }
      else
        t1.zip(t2).map { |t1_e, t2_e| combine(func, t1_e, t2_e) }
      end
    end
  end
end
