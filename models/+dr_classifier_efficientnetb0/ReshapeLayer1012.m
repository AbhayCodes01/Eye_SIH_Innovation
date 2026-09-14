classdef ReshapeLayer1012 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.ReshapeLayer1012';
        end
    end


    methods
        function this = ReshapeLayer1012(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_118'};
        end

        function [sequential_1_eff_118] = predict(this, sequential_1_eff_127)
            if isdlarray(sequential_1_eff_127)
                sequential_1_eff_127 = stripdims(sequential_1_eff_127);
            end
            sequential_1_eff_127NumDims = 4;
            sequential_1_eff_127 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_127, [4 3 1 2], 4);

            [sequential_1_eff_118, sequential_1_eff_118NumDims] = ReshapeGraph1024(this, sequential_1_eff_127, sequential_1_eff_127NumDims, false);
            sequential_1_eff_118 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_118, [3 4 2 1], 4);

            sequential_1_eff_118 = dlarray(single(sequential_1_eff_118), 'SSCB');
        end

        function [sequential_1_eff_118] = forward(this, sequential_1_eff_127)
            if isdlarray(sequential_1_eff_127)
                sequential_1_eff_127 = stripdims(sequential_1_eff_127);
            end
            sequential_1_eff_127NumDims = 4;
            sequential_1_eff_127 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_127, [4 3 1 2], 4);

            [sequential_1_eff_118, sequential_1_eff_118NumDims] = ReshapeGraph1024(this, sequential_1_eff_127, sequential_1_eff_127NumDims, true);
            sequential_1_eff_118 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_118, [3 4 2 1], 4);

            sequential_1_eff_118 = dlarray(single(sequential_1_eff_118), 'SSCB');
        end

        function [sequential_1_eff_118, sequential_1_eff_118NumDims1025] = ReshapeGraph1024(this, sequential_1_eff_127, sequential_1_eff_127NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape, sequential_1_eff_118NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_127, this.Vars.new_shape__1100, sequential_1_eff_127NumDims, 0);
            sequential_1_eff_118 = reshape(sequential_1_eff_127, shape{:});

            % Set graph output arguments
            sequential_1_eff_118NumDims1025 = sequential_1_eff_118NumDims;

        end

    end

end