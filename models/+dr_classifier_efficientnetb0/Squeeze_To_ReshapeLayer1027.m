classdef Squeeze_To_ReshapeLayer1027 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1027';
        end
    end


    methods
        function this = Squeeze_To_ReshapeLayer1027(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_311'};
        end

        function [sequential_1_eff_311] = predict(this, sequential_1_eff_316)
            if isdlarray(sequential_1_eff_316)
                sequential_1_eff_316 = stripdims(sequential_1_eff_316);
            end
            sequential_1_eff_316NumDims = 4;
            sequential_1_eff_316 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_316, [4 3 1 2], 4);

            [sequential_1_eff_311, sequential_1_eff_311NumDims] = Squeeze_To_ReshapeGraph1054(this, sequential_1_eff_316, sequential_1_eff_316NumDims, false);
            sequential_1_eff_311 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_311, [3 4 2 1], 4);

            sequential_1_eff_311 = dlarray(single(sequential_1_eff_311), 'SSCB');
        end

        function [sequential_1_eff_311] = forward(this, sequential_1_eff_316)
            if isdlarray(sequential_1_eff_316)
                sequential_1_eff_316 = stripdims(sequential_1_eff_316);
            end
            sequential_1_eff_316NumDims = 4;
            sequential_1_eff_316 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_316, [4 3 1 2], 4);

            [sequential_1_eff_311, sequential_1_eff_311NumDims] = Squeeze_To_ReshapeGraph1054(this, sequential_1_eff_316, sequential_1_eff_316NumDims, true);
            sequential_1_eff_311 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_311, [3 4 2 1], 4);

            sequential_1_eff_311 = dlarray(single(sequential_1_eff_311), 'SSCB');
        end

        function [sequential_1_eff_311, sequential_1_eff_311NumDims1055] = Squeeze_To_ReshapeGraph1054(this, sequential_1_eff_316, sequential_1_eff_316NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_eff_317, sequential_1_eff_317NumDims] = dr_classifier_efficientnetb0.ops.onnxSqueeze(sequential_1_eff_316, this.Vars.const_axes__1282, sequential_1_eff_316NumDims);

            % Reshape:
            [shape, sequential_1_eff_311NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_317, this.Vars.new_shape__1118, sequential_1_eff_317NumDims, 0);
            sequential_1_eff_311 = reshape(sequential_1_eff_317, shape{:});

            % Set graph output arguments
            sequential_1_eff_311NumDims1055 = sequential_1_eff_311NumDims;

        end

    end

end