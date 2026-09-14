classdef Squeeze_To_ReshapeLayer1011 < nnet.layer.Layer & nnet.layer.Formattable
    % A custom layer auto-generated while importing an ONNX network.

    %#ok<*PROPLC>
    %#ok<*NBRAK>
    %#ok<*INUSL>
    %#ok<*VARARG>
    properties (Learnable)
    end

    properties (State)
    end

    properties
        Vars
        NumDims
    end


    methods(Static, Hidden)
        % Specify the path to the class that will be used for codegen
        function name = matlabCodegenRedirect(~)
            name = 'dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1011';
        end
    end


    methods
        function this = Squeeze_To_ReshapeLayer1011(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_123'};
        end

        function [sequential_1_eff_123] = predict(this, sequential_1_eff_128)
            if isdlarray(sequential_1_eff_128)
                sequential_1_eff_128 = stripdims(sequential_1_eff_128);
            end
            sequential_1_eff_128NumDims = 4;
            sequential_1_eff_128 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_128, [4 3 1 2], 4);

            [sequential_1_eff_123, sequential_1_eff_123NumDims] = Squeeze_To_ReshapeGraph1022(this, sequential_1_eff_128, sequential_1_eff_128NumDims, false);
            sequential_1_eff_123 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_123, [3 4 2 1], 4);

            sequential_1_eff_123 = dlarray(single(sequential_1_eff_123), 'SSCB');
        end

        function [sequential_1_eff_123] = forward(this, sequential_1_eff_128)
            if isdlarray(sequential_1_eff_128)
                sequential_1_eff_128 = stripdims(sequential_1_eff_128);
            end
            sequential_1_eff_128NumDims = 4;
            sequential_1_eff_128 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_128, [4 3 1 2], 4);

            [sequential_1_eff_123, sequential_1_eff_123NumDims] = Squeeze_To_ReshapeGraph1022(this, sequential_1_eff_128, sequential_1_eff_128NumDims, true);
            sequential_1_eff_123 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_123, [3 4 2 1], 4);

            sequential_1_eff_123 = dlarray(single(sequential_1_eff_123), 'SSCB');
        end

        function [sequential_1_eff_123, sequential_1_eff_123NumDims1023] = Squeeze_To_ReshapeGraph1022(this, sequential_1_eff_128, sequential_1_eff_128NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_eff_129, sequential_1_eff_129NumDims] = dr_classifier_efficientnetb0.ops.onnxSqueeze(sequential_1_eff_128, this.Vars.const_axes__1282, sequential_1_eff_128NumDims);

            % Reshape:
            [shape, sequential_1_eff_123NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_129, this.Vars.new_shape__1107, sequential_1_eff_129NumDims, 0);
            sequential_1_eff_123 = reshape(sequential_1_eff_129, shape{:});

            % Set graph output arguments
            sequential_1_eff_123NumDims1023 = sequential_1_eff_123NumDims;

        end

    end

end