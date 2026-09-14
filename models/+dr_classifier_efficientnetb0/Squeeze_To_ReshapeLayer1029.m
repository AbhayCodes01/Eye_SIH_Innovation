classdef Squeeze_To_ReshapeLayer1029 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1029';
        end
    end


    methods
        function this = Squeeze_To_ReshapeLayer1029(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_338'};
        end

        function [sequential_1_eff_338] = predict(this, sequential_1_eff_343)
            if isdlarray(sequential_1_eff_343)
                sequential_1_eff_343 = stripdims(sequential_1_eff_343);
            end
            sequential_1_eff_343NumDims = 4;
            sequential_1_eff_343 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_343, [4 3 1 2], 4);

            [sequential_1_eff_338, sequential_1_eff_338NumDims] = Squeeze_To_ReshapeGraph1058(this, sequential_1_eff_343, sequential_1_eff_343NumDims, false);
            sequential_1_eff_338 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_338, [3 4 2 1], 4);

            sequential_1_eff_338 = dlarray(single(sequential_1_eff_338), 'SSCB');
        end

        function [sequential_1_eff_338] = forward(this, sequential_1_eff_343)
            if isdlarray(sequential_1_eff_343)
                sequential_1_eff_343 = stripdims(sequential_1_eff_343);
            end
            sequential_1_eff_343NumDims = 4;
            sequential_1_eff_343 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_343, [4 3 1 2], 4);

            [sequential_1_eff_338, sequential_1_eff_338NumDims] = Squeeze_To_ReshapeGraph1058(this, sequential_1_eff_343, sequential_1_eff_343NumDims, true);
            sequential_1_eff_338 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_338, [3 4 2 1], 4);

            sequential_1_eff_338 = dlarray(single(sequential_1_eff_338), 'SSCB');
        end

        function [sequential_1_eff_338, sequential_1_eff_338NumDims1059] = Squeeze_To_ReshapeGraph1058(this, sequential_1_eff_343, sequential_1_eff_343NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_eff_344, sequential_1_eff_344NumDims] = dr_classifier_efficientnetb0.ops.onnxSqueeze(sequential_1_eff_343, this.Vars.const_axes__1282, sequential_1_eff_343NumDims);

            % Reshape:
            [shape, sequential_1_eff_338NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_344, this.Vars.new_shape__1127, sequential_1_eff_344NumDims, 0);
            sequential_1_eff_338 = reshape(sequential_1_eff_344, shape{:});

            % Set graph output arguments
            sequential_1_eff_338NumDims1059 = sequential_1_eff_338NumDims;

        end

    end

end