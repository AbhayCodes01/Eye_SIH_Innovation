classdef ReshapeLayer1032 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.ReshapeLayer1032';
        end
    end


    methods
        function this = ReshapeLayer1032(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_360'};
        end

        function [sequential_1_eff_360] = predict(this, sequential_1_eff_369)
            if isdlarray(sequential_1_eff_369)
                sequential_1_eff_369 = stripdims(sequential_1_eff_369);
            end
            sequential_1_eff_369NumDims = 4;
            sequential_1_eff_369 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_369, [4 3 1 2], 4);

            [sequential_1_eff_360, sequential_1_eff_360NumDims] = ReshapeGraph1064(this, sequential_1_eff_369, sequential_1_eff_369NumDims, false);
            sequential_1_eff_360 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_360, [3 4 2 1], 4);

            sequential_1_eff_360 = dlarray(single(sequential_1_eff_360), 'SSCB');
        end

        function [sequential_1_eff_360] = forward(this, sequential_1_eff_369)
            if isdlarray(sequential_1_eff_369)
                sequential_1_eff_369 = stripdims(sequential_1_eff_369);
            end
            sequential_1_eff_369NumDims = 4;
            sequential_1_eff_369 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_369, [4 3 1 2], 4);

            [sequential_1_eff_360, sequential_1_eff_360NumDims] = ReshapeGraph1064(this, sequential_1_eff_369, sequential_1_eff_369NumDims, true);
            sequential_1_eff_360 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_360, [3 4 2 1], 4);

            sequential_1_eff_360 = dlarray(single(sequential_1_eff_360), 'SSCB');
        end

        function [sequential_1_eff_360, sequential_1_eff_360NumDims1065] = ReshapeGraph1064(this, sequential_1_eff_369, sequential_1_eff_369NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape, sequential_1_eff_360NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_369, this.Vars.new_shape__1129, sequential_1_eff_369NumDims, 0);
            sequential_1_eff_360 = reshape(sequential_1_eff_369, shape{:});

            % Set graph output arguments
            sequential_1_eff_360NumDims1065 = sequential_1_eff_360NumDims;

        end

    end

end