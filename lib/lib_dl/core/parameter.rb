# frozen_string_literal: true

module LibDL
  # A class which represnets a layer's parameters. A parameter
  # contains a tensor which holds data and a tensor holding its gradient,
  # which has the same shape as the data tensor.
  class Parameter
    attr_accessor :data, :grad

    def initialize(data)
      @data = data
      zero_grad
    end

    # Zero the gradient tensor
    def zero_grad
      @grad = LibDL.zeros_like(data)
    end
  end
end
