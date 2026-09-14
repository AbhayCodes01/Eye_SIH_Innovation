classdef Squeeze_To_ReshapeLayer1035 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1035';
        end
    end


    methods
        function this = Squeeze_To_ReshapeLayer1035(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_418'};
        end

        function [sequential_1_eff_418] = predict(this, sequential_1_eff_423)
            if isdlarray(sequential_1_eff_423)
                sequential_1_eff_423 = stripdims(sequential_1_eff_423);
            end
            sequential_1_eff_423NumDims = 4;
            sequential_1_eff_423 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_423, [4 3 1 2], 4);

            [sequential_1_eff_418, sequential_1_eff_418NumDims] = Squeeze_To_ReshapeGraph1070(this, sequential_1_eff_423, sequential_1_eff_423NumDims, false);
            sequential_1_eff_418 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_418, [3 4 2 1], 4);

            sequential_1_eff_418 = dlarray(single(sequential_1_eff_418), 'SSCB');
        end

        function [sequential_1_eff_418] = forward(this, sequential_1_eff_423)
            if isdlarray(sequential_1_eff_423)
                sequential_1_eff_423 = stripdims(sequential_1_eff_423);
            end
            sequential_1_eff_423NumDims = 4;
            sequential_1_eff_423 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_423, [4 3 1 2], 4);

            [sequential_1_eff_418, sequential_1_eff_418NumDims] = Squeeze_To_ReshapeGraph1070(this, sequential_1_eff_423, sequential_1_eff_423NumDims, true);
            sequential_1_eff_418 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_418, [3 4 2 1], 4);

            sequential_1_eff_418 = dlarray(single(sequential_1_eff_418), 'SSCB');
        end

        function [sequential_1_eff_418, sequential_1_eff_418NumDims1071] = Squeeze_To_ReshapeGraph1070(this, sequential_1_eff_423, sequential_1_eff_423NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_eff_424, sequential_1_eff_424NumDims] = dr_classifier_efficientnetb0.ops.onnxSqueeze(sequential_1_eff_423, this.Vars.const_axes__1282, sequential_1_eff_423NumDims);

            % Reshape:
            [shape, sequential_1_eff_418NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_424, this.Vars.new_shape__1127, sequential_1_eff_424NumDims, 0);
            sequential_1_eff_418 = reshape(sequential_1_eff_424, shape{:});

            % Set graph output arguments
            sequential_1_eff_418NumDims1071 = sequential_1_eff_418NumDims;

        end

    end

end