classdef ReshapeLayer1017 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.ReshapeLayer1017';
        end
    end


    methods
        function this = ReshapeLayer1017(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_172'};
        end

        function [sequential_1_eff_172] = predict(this, sequential_1_eff_181)
            if isdlarray(sequential_1_eff_181)
                sequential_1_eff_181 = stripdims(sequential_1_eff_181);
            end
            sequential_1_eff_181NumDims = 4;
            sequential_1_eff_181 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_181, [4 3 1 2], 4);

            [sequential_1_eff_172, sequential_1_eff_172NumDims] = ReshapeGraph1034(this, sequential_1_eff_181, sequential_1_eff_181NumDims, false);
            sequential_1_eff_172 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_172, [3 4 2 1], 4);

            sequential_1_eff_172 = dlarray(single(sequential_1_eff_172), 'SSCB');
        end

        function [sequential_1_eff_172] = forward(this, sequential_1_eff_181)
            if isdlarray(sequential_1_eff_181)
                sequential_1_eff_181 = stripdims(sequential_1_eff_181);
            end
            sequential_1_eff_181NumDims = 4;
            sequential_1_eff_181 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_181, [4 3 1 2], 4);

            [sequential_1_eff_172, sequential_1_eff_172NumDims] = ReshapeGraph1034(this, sequential_1_eff_181, sequential_1_eff_181NumDims, true);
            sequential_1_eff_172 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_172, [3 4 2 1], 4);

            sequential_1_eff_172 = dlarray(single(sequential_1_eff_172), 'SSCB');
        end

        function [sequential_1_eff_172, sequential_1_eff_172NumDims1035] = ReshapeGraph1034(this, sequential_1_eff_181, sequential_1_eff_181NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape, sequential_1_eff_172NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_181, this.Vars.new_shape__1139, sequential_1_eff_181NumDims, 0);
            sequential_1_eff_172 = reshape(sequential_1_eff_181, shape{:});

            % Set graph output arguments
            sequential_1_eff_172NumDims1035 = sequential_1_eff_172NumDims;

        end

    end

end