classdef ReshapeLayer1036 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.ReshapeLayer1036';
        end
    end


    methods
        function this = ReshapeLayer1036(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_413'};
        end

        function [sequential_1_eff_413] = predict(this, sequential_1_eff_422)
            if isdlarray(sequential_1_eff_422)
                sequential_1_eff_422 = stripdims(sequential_1_eff_422);
            end
            sequential_1_eff_422NumDims = 4;
            sequential_1_eff_422 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_422, [4 3 1 2], 4);

            [sequential_1_eff_413, sequential_1_eff_413NumDims] = ReshapeGraph1072(this, sequential_1_eff_422, sequential_1_eff_422NumDims, false);
            sequential_1_eff_413 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_413, [3 4 2 1], 4);

            sequential_1_eff_413 = dlarray(single(sequential_1_eff_413), 'SSCB');
        end

        function [sequential_1_eff_413] = forward(this, sequential_1_eff_422)
            if isdlarray(sequential_1_eff_422)
                sequential_1_eff_422 = stripdims(sequential_1_eff_422);
            end
            sequential_1_eff_422NumDims = 4;
            sequential_1_eff_422 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_422, [4 3 1 2], 4);

            [sequential_1_eff_413, sequential_1_eff_413NumDims] = ReshapeGraph1072(this, sequential_1_eff_422, sequential_1_eff_422NumDims, true);
            sequential_1_eff_413 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_413, [3 4 2 1], 4);

            sequential_1_eff_413 = dlarray(single(sequential_1_eff_413), 'SSCB');
        end

        function [sequential_1_eff_413, sequential_1_eff_413NumDims1073] = ReshapeGraph1072(this, sequential_1_eff_422, sequential_1_eff_422NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape, sequential_1_eff_413NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_422, this.Vars.new_shape__1129, sequential_1_eff_422NumDims, 0);
            sequential_1_eff_413 = reshape(sequential_1_eff_422, shape{:});

            % Set graph output arguments
            sequential_1_eff_413NumDims1073 = sequential_1_eff_413NumDims;

        end

    end

end