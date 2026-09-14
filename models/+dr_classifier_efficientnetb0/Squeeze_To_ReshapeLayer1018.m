classdef Squeeze_To_ReshapeLayer1018 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1018';
        end
    end


    methods
        function this = Squeeze_To_ReshapeLayer1018(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_204'};
        end

        function [sequential_1_eff_204] = predict(this, sequential_1_eff_209)
            if isdlarray(sequential_1_eff_209)
                sequential_1_eff_209 = stripdims(sequential_1_eff_209);
            end
            sequential_1_eff_209NumDims = 4;
            sequential_1_eff_209 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_209, [4 3 1 2], 4);

            [sequential_1_eff_204, sequential_1_eff_204NumDims] = Squeeze_To_ReshapeGraph1036(this, sequential_1_eff_209, sequential_1_eff_209NumDims, false);
            sequential_1_eff_204 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_204, [3 4 2 1], 4);

            sequential_1_eff_204 = dlarray(single(sequential_1_eff_204), 'SSCB');
        end

        function [sequential_1_eff_204] = forward(this, sequential_1_eff_209)
            if isdlarray(sequential_1_eff_209)
                sequential_1_eff_209 = stripdims(sequential_1_eff_209);
            end
            sequential_1_eff_209NumDims = 4;
            sequential_1_eff_209 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_209, [4 3 1 2], 4);

            [sequential_1_eff_204, sequential_1_eff_204NumDims] = Squeeze_To_ReshapeGraph1036(this, sequential_1_eff_209, sequential_1_eff_209NumDims, true);
            sequential_1_eff_204 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_204, [3 4 2 1], 4);

            sequential_1_eff_204 = dlarray(single(sequential_1_eff_204), 'SSCB');
        end

        function [sequential_1_eff_204, sequential_1_eff_204NumDims1037] = Squeeze_To_ReshapeGraph1036(this, sequential_1_eff_209, sequential_1_eff_209NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_eff_210, sequential_1_eff_210NumDims] = dr_classifier_efficientnetb0.ops.onnxSqueeze(sequential_1_eff_209, this.Vars.const_axes__1282, sequential_1_eff_209NumDims);

            % Reshape:
            [shape, sequential_1_eff_204NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_210, this.Vars.new_shape__1124, sequential_1_eff_210NumDims, 0);
            sequential_1_eff_204 = reshape(sequential_1_eff_210, shape{:});

            % Set graph output arguments
            sequential_1_eff_204NumDims1037 = sequential_1_eff_204NumDims;

        end

    end

end