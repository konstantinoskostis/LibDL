# frozen_string_literal: true

module LibDL
  # The linear layer applies a linear transformation to the incoming data,
  # using the formula: Y = WX + B
  class Linear < Module
    def initialize(in_features, out_features, bias: true)
      super()

      @in_features = in_features
      @out_features = out_features

      @weight = LibDL.zeros(@in_features, @out_features) # Parameter object with in/out features
      @bias = 1 if bias

      reset_parameters()
    end

    # Initialize weeight and bias parameters
    #
    # @return [void]
    def reset_parameters(); end

    # Run the forward computation given an input
    #
    # @param input [LibDL::Tensor] The input tensor
    # @return [LibDL::Tensor] The ouput tensor as a result of the linear transformation
    def forward(input)
      input
    end
  end
end
