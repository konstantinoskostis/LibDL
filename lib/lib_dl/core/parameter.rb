# frozen_string_literal: true

module LibDL
  # A class which represents a trainable parameter that is part of
  # a neural net layer. A parameter contains a tensor which holds data and
  # a tensor which holds the gradient of the data. These two tensors have the
  # same shape
  class Parameter
    attr_accessor :data, :grad

    def initialize(data)
      @data = data
      @data = LibDL.tensor(@data) unless @data.is_a?(LibDL::Tensor)

      @grad = LibDL.zeros_like(@data)
    end
  end
end
