classdef Squeeze_To_ReshapeLayer1033 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1033';
        end
    end


    methods
        function this = Squeeze_To_ReshapeLayer1033(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_392'};
        end

        function [sequential_1_eff_392] = predict(this, sequential_1_eff_397)
            if isdlarray(sequential_1_eff_397)
                sequential_1_eff_397 = stripdims(sequential_1_eff_397);
            end
            sequential_1_eff_397NumDims = 4;
            sequential_1_eff_397 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_397, [4 3 1 2], 4);

            [sequential_1_eff_392, sequential_1_eff_392NumDims] = Squeeze_To_ReshapeGraph1066(this, sequential_1_eff_397, sequential_1_eff_397NumDims, false);
            sequential_1_eff_392 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_392, [3 4 2 1], 4);

            sequential_1_eff_392 = dlarray(single(sequential_1_eff_392), 'SSCB');
        end

        function [sequential_1_eff_392] = forward(this, sequential_1_eff_397)
            if isdlarray(sequential_1_eff_397)
                sequential_1_eff_397 = stripdims(sequential_1_eff_397);
            end
            sequential_1_eff_397NumDims = 4;
            sequential_1_eff_397 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_397, [4 3 1 2], 4);

            [sequential_1_eff_392, sequential_1_eff_392NumDims] = Squeeze_To_ReshapeGraph1066(this, sequential_1_eff_397, sequential_1_eff_397NumDims, true);
            sequential_1_eff_392 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_392, [3 4 2 1], 4);

            sequential_1_eff_392 = dlarray(single(sequential_1_eff_392), 'SSCB');
        end

        function [sequential_1_eff_392, sequential_1_eff_392NumDims1067] = Squeeze_To_ReshapeGraph1066(this, sequential_1_eff_397, sequential_1_eff_397NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_eff_398, sequential_1_eff_398NumDims] = dr_classifier_efficientnetb0.ops.onnxSqueeze(sequential_1_eff_397, this.Vars.const_axes__1282, sequential_1_eff_397NumDims);

            % Reshape:
            [shape, sequential_1_eff_392NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_398, this.Vars.new_shape__1127, sequential_1_eff_398NumDims, 0);
            sequential_1_eff_392 = reshape(sequential_1_eff_398, shape{:});

            % Set graph output arguments
            sequential_1_eff_392NumDims1067 = sequential_1_eff_392NumDims;

        end

    end

end