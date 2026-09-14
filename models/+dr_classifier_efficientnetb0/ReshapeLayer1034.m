classdef ReshapeLayer1034 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.ReshapeLayer1034';
        end
    end


    methods
        function this = ReshapeLayer1034(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_387'};
        end

        function [sequential_1_eff_387] = predict(this, sequential_1_eff_396)
            if isdlarray(sequential_1_eff_396)
                sequential_1_eff_396 = stripdims(sequential_1_eff_396);
            end
            sequential_1_eff_396NumDims = 4;
            sequential_1_eff_396 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_396, [4 3 1 2], 4);

            [sequential_1_eff_387, sequential_1_eff_387NumDims] = ReshapeGraph1068(this, sequential_1_eff_396, sequential_1_eff_396NumDims, false);
            sequential_1_eff_387 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_387, [3 4 2 1], 4);

            sequential_1_eff_387 = dlarray(single(sequential_1_eff_387), 'SSCB');
        end

        function [sequential_1_eff_387] = forward(this, sequential_1_eff_396)
            if isdlarray(sequential_1_eff_396)
                sequential_1_eff_396 = stripdims(sequential_1_eff_396);
            end
            sequential_1_eff_396NumDims = 4;
            sequential_1_eff_396 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_396, [4 3 1 2], 4);

            [sequential_1_eff_387, sequential_1_eff_387NumDims] = ReshapeGraph1068(this, sequential_1_eff_396, sequential_1_eff_396NumDims, true);
            sequential_1_eff_387 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_387, [3 4 2 1], 4);

            sequential_1_eff_387 = dlarray(single(sequential_1_eff_387), 'SSCB');
        end

        function [sequential_1_eff_387, sequential_1_eff_387NumDims1069] = ReshapeGraph1068(this, sequential_1_eff_396, sequential_1_eff_396NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape, sequential_1_eff_387NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_396, this.Vars.new_shape__1129, sequential_1_eff_396NumDims, 0);
            sequential_1_eff_387 = reshape(sequential_1_eff_396, shape{:});

            % Set graph output arguments
            sequential_1_eff_387NumDims1069 = sequential_1_eff_387NumDims;

        end

    end

end