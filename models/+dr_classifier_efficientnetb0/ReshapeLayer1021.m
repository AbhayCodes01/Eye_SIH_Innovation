classdef ReshapeLayer1021 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.ReshapeLayer1021';
        end
    end


    methods
        function this = ReshapeLayer1021(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_225'};
        end

        function [sequential_1_eff_225] = predict(this, sequential_1_eff_234)
            if isdlarray(sequential_1_eff_234)
                sequential_1_eff_234 = stripdims(sequential_1_eff_234);
            end
            sequential_1_eff_234NumDims = 4;
            sequential_1_eff_234 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_234, [4 3 1 2], 4);

            [sequential_1_eff_225, sequential_1_eff_225NumDims] = ReshapeGraph1042(this, sequential_1_eff_234, sequential_1_eff_234NumDims, false);
            sequential_1_eff_225 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_225, [3 4 2 1], 4);

            sequential_1_eff_225 = dlarray(single(sequential_1_eff_225), 'SSCB');
        end

        function [sequential_1_eff_225] = forward(this, sequential_1_eff_234)
            if isdlarray(sequential_1_eff_234)
                sequential_1_eff_234 = stripdims(sequential_1_eff_234);
            end
            sequential_1_eff_234NumDims = 4;
            sequential_1_eff_234 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_234, [4 3 1 2], 4);

            [sequential_1_eff_225, sequential_1_eff_225NumDims] = ReshapeGraph1042(this, sequential_1_eff_234, sequential_1_eff_234NumDims, true);
            sequential_1_eff_225 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_225, [3 4 2 1], 4);

            sequential_1_eff_225 = dlarray(single(sequential_1_eff_225), 'SSCB');
        end

        function [sequential_1_eff_225, sequential_1_eff_225NumDims1043] = ReshapeGraph1042(this, sequential_1_eff_234, sequential_1_eff_234NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape, sequential_1_eff_225NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_234, this.Vars.new_shape__1139, sequential_1_eff_234NumDims, 0);
            sequential_1_eff_225 = reshape(sequential_1_eff_234, shape{:});

            % Set graph output arguments
            sequential_1_eff_225NumDims1043 = sequential_1_eff_225NumDims;

        end

    end

end