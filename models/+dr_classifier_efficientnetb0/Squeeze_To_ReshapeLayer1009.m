classdef Squeeze_To_ReshapeLayer1009 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1009';
        end
    end


    methods
        function this = Squeeze_To_ReshapeLayer1009(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_effi_96'};
        end

        function [sequential_1_effi_96] = predict(this, sequential_1_eff_101)
            if isdlarray(sequential_1_eff_101)
                sequential_1_eff_101 = stripdims(sequential_1_eff_101);
            end
            sequential_1_eff_101NumDims = 4;
            sequential_1_eff_101 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_101, [4 3 1 2], 4);

            [sequential_1_effi_96, sequential_1_effi_96NumDims] = Squeeze_To_ReshapeGraph1018(this, sequential_1_eff_101, sequential_1_eff_101NumDims, false);
            sequential_1_effi_96 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_96, [3 4 2 1], 4);

            sequential_1_effi_96 = dlarray(single(sequential_1_effi_96), 'SSCB');
        end

        function [sequential_1_effi_96] = forward(this, sequential_1_eff_101)
            if isdlarray(sequential_1_eff_101)
                sequential_1_eff_101 = stripdims(sequential_1_eff_101);
            end
            sequential_1_eff_101NumDims = 4;
            sequential_1_eff_101 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_101, [4 3 1 2], 4);

            [sequential_1_effi_96, sequential_1_effi_96NumDims] = Squeeze_To_ReshapeGraph1018(this, sequential_1_eff_101, sequential_1_eff_101NumDims, true);
            sequential_1_effi_96 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_96, [3 4 2 1], 4);

            sequential_1_effi_96 = dlarray(single(sequential_1_effi_96), 'SSCB');
        end

        function [sequential_1_effi_96, sequential_1_effi_96NumDims1019] = Squeeze_To_ReshapeGraph1018(this, sequential_1_eff_101, sequential_1_eff_101NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_eff_102, sequential_1_eff_102NumDims] = dr_classifier_efficientnetb0.ops.onnxSqueeze(sequential_1_eff_101, this.Vars.const_axes__1282, sequential_1_eff_101NumDims);

            % Reshape:
            [shape, sequential_1_effi_96NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_102, this.Vars.new_shape__1130, sequential_1_eff_102NumDims, 0);
            sequential_1_effi_96 = reshape(sequential_1_eff_102, shape{:});

            % Set graph output arguments
            sequential_1_effi_96NumDims1019 = sequential_1_effi_96NumDims;

        end

    end

end