# frozen_string_literal: true

module LibDL
  # Represents a neural net layer. It is the base of all layers in LibDL.
  class Layer
    def forward
      raise NotImplementedError, 'Subclasses must implement forward'
    end

    def backward
      raise NotImplementedError, 'Subclasses must implement forward'
    end
  end

  # Make Function an alias of Layer
  Function = Layer
  Module = Layer
end
