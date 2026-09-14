classdef Squeeze_To_ReshapeLayer1016 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1016';
        end
    end


    methods
        function this = Squeeze_To_ReshapeLayer1016(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_177'};
        end

        function [sequential_1_eff_177] = predict(this, sequential_1_eff_182)
            if isdlarray(sequential_1_eff_182)
                sequential_1_eff_182 = stripdims(sequential_1_eff_182);
            end
            sequential_1_eff_182NumDims = 4;
            sequential_1_eff_182 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_182, [4 3 1 2], 4);

            [sequential_1_eff_177, sequential_1_eff_177NumDims] = Squeeze_To_ReshapeGraph1032(this, sequential_1_eff_182, sequential_1_eff_182NumDims, false);
            sequential_1_eff_177 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_177, [3 4 2 1], 4);

            sequential_1_eff_177 = dlarray(single(sequential_1_eff_177), 'SSCB');
        end

        function [sequential_1_eff_177] = forward(this, sequential_1_eff_182)
            if isdlarray(sequential_1_eff_182)
                sequential_1_eff_182 = stripdims(sequential_1_eff_182);
            end
            sequential_1_eff_182NumDims = 4;
            sequential_1_eff_182 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_182, [4 3 1 2], 4);

            [sequential_1_eff_177, sequential_1_eff_177NumDims] = Squeeze_To_ReshapeGraph1032(this, sequential_1_eff_182, sequential_1_eff_182NumDims, true);
            sequential_1_eff_177 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_177, [3 4 2 1], 4);

            sequential_1_eff_177 = dlarray(single(sequential_1_eff_177), 'SSCB');
        end

        function [sequential_1_eff_177, sequential_1_eff_177NumDims1033] = Squeeze_To_ReshapeGraph1032(this, sequential_1_eff_182, sequential_1_eff_182NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_eff_183, sequential_1_eff_183NumDims] = dr_classifier_efficientnetb0.ops.onnxSqueeze(sequential_1_eff_182, this.Vars.const_axes__1282, sequential_1_eff_182NumDims);

            % Reshape:
            [shape, sequential_1_eff_177NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_183, this.Vars.new_shape__1124, sequential_1_eff_183NumDims, 0);
            sequential_1_eff_177 = reshape(sequential_1_eff_183, shape{:});

            % Set graph output arguments
            sequential_1_eff_177NumDims1033 = sequential_1_eff_177NumDims;

        end

    end

end