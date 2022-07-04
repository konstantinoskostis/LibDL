# frozen_string_literal: true

module LibDL
  # The linear layer applies a linear transformation to the incoming data,
  # using the formula: Y = WX + B
  class Linear < Module
    def initialize(in_features, out_features, bias: true)
      super()

      @in_features = in_features
      @out_features = out_features

      @weight = [] # Parameter object with in/out features

      @bias = nil

      @bias = 1 if bias
    end

    # Run the forward computation given an input
    #
    # @param input [LibDL::Tensor] The input tensor
    # @return [LibDL::Tensor] The ouput tensor as a result of the linear transformation
    def forward(input)
      input
    end
  end
end
