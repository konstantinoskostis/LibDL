# frozen_string_literal: true

module LibDL
  # This module represents initializers used for initializing
  # tensors/parameters/weights. The structure and implementation
  # tries to follow Tensorflow.
  module Initializers
    # The base class for all initializers
    class Base
      # Implement the initializer's core logic
      #
      # @param shape [Array<Integer>] The shape of the output
      # @param kwargs [Hash] A set of options to consider
      # @return [LibDL::Tensor]
      def call(_shape, _kwargs = {})
        raise NotImplementedError, 'Subclasses must implement `call`'
      end

      # Return the configuration of the initializer
      #
      # @note Subclasses may implement this.
      #
      # @return [Hash]
      def config
        {}
      end

      # Instantiate an initializer given a config
      #
      # @param cfg [Hash] The output of `config` method
      # @return [LibDL::Initializers::Base] An initializer
      def self.from_config(cfg)
        new(**cfg)
      end
    end
  end
end
