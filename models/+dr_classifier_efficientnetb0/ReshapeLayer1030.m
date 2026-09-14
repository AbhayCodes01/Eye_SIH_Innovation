classdef ReshapeLayer1030 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.ReshapeLayer1030';
        end
    end


    methods
        function this = ReshapeLayer1030(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_333'};
        end

        function [sequential_1_eff_333] = predict(this, sequential_1_eff_342)
            if isdlarray(sequential_1_eff_342)
                sequential_1_eff_342 = stripdims(sequential_1_eff_342);
            end
            sequential_1_eff_342NumDims = 4;
            sequential_1_eff_342 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_342, [4 3 1 2], 4);

            [sequential_1_eff_333, sequential_1_eff_333NumDims] = ReshapeGraph1060(this, sequential_1_eff_342, sequential_1_eff_342NumDims, false);
            sequential_1_eff_333 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_333, [3 4 2 1], 4);

            sequential_1_eff_333 = dlarray(single(sequential_1_eff_333), 'SSCB');
        end

        function [sequential_1_eff_333] = forward(this, sequential_1_eff_342)
            if isdlarray(sequential_1_eff_342)
                sequential_1_eff_342 = stripdims(sequential_1_eff_342);
            end
            sequential_1_eff_342NumDims = 4;
            sequential_1_eff_342 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_342, [4 3 1 2], 4);

            [sequential_1_eff_333, sequential_1_eff_333NumDims] = ReshapeGraph1060(this, sequential_1_eff_342, sequential_1_eff_342NumDims, true);
            sequential_1_eff_333 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_333, [3 4 2 1], 4);

            sequential_1_eff_333 = dlarray(single(sequential_1_eff_333), 'SSCB');
        end

        function [sequential_1_eff_333, sequential_1_eff_333NumDims1061] = ReshapeGraph1060(this, sequential_1_eff_342, sequential_1_eff_342NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape, sequential_1_eff_333NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_342, this.Vars.new_shape__1129, sequential_1_eff_342NumDims, 0);
            sequential_1_eff_333 = reshape(sequential_1_eff_342, shape{:});

            % Set graph output arguments
            sequential_1_eff_333NumDims1061 = sequential_1_eff_333NumDims;

        end

    end

end