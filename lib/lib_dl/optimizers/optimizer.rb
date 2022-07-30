# frozen_string_literal: true

module LibDL
  # A module containing a set of optimizers
  module Optimizers
    # The base class of all optimizers.
    class Optimizer
      def initialize(params)
        @param_groups = params
      end

      def step
        raise NotImplementedError, 'Subclasses must implement step'
      end

      def zero_grad
        @param_groups.each do |param_group|
          param_group.each do |param|
            param.grad = param.grad * 0
          end
        end
      end
    end
  end
end
