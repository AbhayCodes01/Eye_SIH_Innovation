classdef Squeeze_To_ReshapeLayer1031 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1031';
        end
    end


    methods
        function this = Squeeze_To_ReshapeLayer1031(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_365'};
        end

        function [sequential_1_eff_365] = predict(this, sequential_1_eff_370)
            if isdlarray(sequential_1_eff_370)
                sequential_1_eff_370 = stripdims(sequential_1_eff_370);
            end
            sequential_1_eff_370NumDims = 4;
            sequential_1_eff_370 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_370, [4 3 1 2], 4);

            [sequential_1_eff_365, sequential_1_eff_365NumDims] = Squeeze_To_ReshapeGraph1062(this, sequential_1_eff_370, sequential_1_eff_370NumDims, false);
            sequential_1_eff_365 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_365, [3 4 2 1], 4);

            sequential_1_eff_365 = dlarray(single(sequential_1_eff_365), 'SSCB');
        end

        function [sequential_1_eff_365] = forward(this, sequential_1_eff_370)
            if isdlarray(sequential_1_eff_370)
                sequential_1_eff_370 = stripdims(sequential_1_eff_370);
            end
            sequential_1_eff_370NumDims = 4;
            sequential_1_eff_370 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_370, [4 3 1 2], 4);

            [sequential_1_eff_365, sequential_1_eff_365NumDims] = Squeeze_To_ReshapeGraph1062(this, sequential_1_eff_370, sequential_1_eff_370NumDims, true);
            sequential_1_eff_365 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_365, [3 4 2 1], 4);

            sequential_1_eff_365 = dlarray(single(sequential_1_eff_365), 'SSCB');
        end

        function [sequential_1_eff_365, sequential_1_eff_365NumDims1063] = Squeeze_To_ReshapeGraph1062(this, sequential_1_eff_370, sequential_1_eff_370NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_eff_371, sequential_1_eff_371NumDims] = dr_classifier_efficientnetb0.ops.onnxSqueeze(sequential_1_eff_370, this.Vars.const_axes__1282, sequential_1_eff_370NumDims);

            % Reshape:
            [shape, sequential_1_eff_365NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_371, this.Vars.new_shape__1127, sequential_1_eff_371NumDims, 0);
            sequential_1_eff_365 = reshape(sequential_1_eff_371, shape{:});

            % Set graph output arguments
            sequential_1_eff_365NumDims1063 = sequential_1_eff_365NumDims;

        end

    end

end