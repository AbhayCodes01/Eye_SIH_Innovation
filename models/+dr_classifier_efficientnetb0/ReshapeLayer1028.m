classdef ReshapeLayer1028 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.ReshapeLayer1028';
        end
    end


    methods
        function this = ReshapeLayer1028(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_306'};
        end

        function [sequential_1_eff_306] = predict(this, sequential_1_eff_315)
            if isdlarray(sequential_1_eff_315)
                sequential_1_eff_315 = stripdims(sequential_1_eff_315);
            end
            sequential_1_eff_315NumDims = 4;
            sequential_1_eff_315 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_315, [4 3 1 2], 4);

            [sequential_1_eff_306, sequential_1_eff_306NumDims] = ReshapeGraph1056(this, sequential_1_eff_315, sequential_1_eff_315NumDims, false);
            sequential_1_eff_306 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_306, [3 4 2 1], 4);

            sequential_1_eff_306 = dlarray(single(sequential_1_eff_306), 'SSCB');
        end

        function [sequential_1_eff_306] = forward(this, sequential_1_eff_315)
            if isdlarray(sequential_1_eff_315)
                sequential_1_eff_315 = stripdims(sequential_1_eff_315);
            end
            sequential_1_eff_315NumDims = 4;
            sequential_1_eff_315 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_315, [4 3 1 2], 4);

            [sequential_1_eff_306, sequential_1_eff_306NumDims] = ReshapeGraph1056(this, sequential_1_eff_315, sequential_1_eff_315NumDims, true);
            sequential_1_eff_306 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_306, [3 4 2 1], 4);

            sequential_1_eff_306 = dlarray(single(sequential_1_eff_306), 'SSCB');
        end

        function [sequential_1_eff_306, sequential_1_eff_306NumDims1057] = ReshapeGraph1056(this, sequential_1_eff_315, sequential_1_eff_315NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape, sequential_1_eff_306NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_315, this.Vars.new_shape__1111, sequential_1_eff_315NumDims, 0);
            sequential_1_eff_306 = reshape(sequential_1_eff_315, shape{:});

            % Set graph output arguments
            sequential_1_eff_306NumDims1057 = sequential_1_eff_306NumDims;

        end

    end

end