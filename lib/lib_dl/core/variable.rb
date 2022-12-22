module LibDL
  # The Variable class is responsible for executing operations on tensors
  # and at the same time constructing a graph in order to keep track of
  # previous nodes, so that back-propagation can be performed.
  class Variable
    attr_accessor :requires_grad, :grad
    attr_reader :value, :parents

    # Initialize a variable
    #
    # @param value [LibDL::Tensor]
    # @param parents [Array<LibDL::Variable>]
    # @param requires_grad [Boolean]
    def initialize(value, parents: [], requires_grad: false)
      @value = value
      @grad = LibDL.zeros_like(value)

      @parents = parents || []
      @requires_grad = requires_grad

      # The backward function as a lambda
      # This should calculate d_output with-respect-to every input/parent
      @_grad_fn = nil
    end

    def +(other)
      raise Errors::VariableError, other if other.class != Variable

      result = @value + other.value
      output = Variable.new(result, parents: [self, other])

      if @requires_grad || other.requires_grad
          output.requires_grad = true
      end

      grad_fn = -> (output) do
        output.parents.each do |parent|
          parent.grad = parent.grad + output.grad
        end
      end

      output.instance_variable_set(:@_grad_fn, grad_fn)

      return output
    end
  end
end
