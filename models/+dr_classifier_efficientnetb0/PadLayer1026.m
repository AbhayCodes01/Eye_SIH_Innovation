classdef PadLayer1026 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.PadLayer1026';
        end
    end


    methods
        function this = PadLayer1026(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_297'};
        end

        function [sequential_1_eff_297] = predict(this, sequential_1_eff_299)
            if isdlarray(sequential_1_eff_299)
                sequential_1_eff_299 = stripdims(sequential_1_eff_299);
            end
            sequential_1_eff_299NumDims = 4;
            sequential_1_eff_299 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_299, [4 3 1 2], 4);

            [sequential_1_eff_297, sequential_1_eff_297NumDims] = PadGraph1052(this, sequential_1_eff_299, sequential_1_eff_299NumDims, false);
            sequential_1_eff_297 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_297, [3 4 2 1], 4);

            sequential_1_eff_297 = dlarray(single(sequential_1_eff_297), 'SSCB');
        end

        function [sequential_1_eff_297] = forward(this, sequential_1_eff_299)
            if isdlarray(sequential_1_eff_299)
                sequential_1_eff_299 = stripdims(sequential_1_eff_299);
            end
            sequential_1_eff_299NumDims = 4;
            sequential_1_eff_299 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_299, [4 3 1 2], 4);

            [sequential_1_eff_297, sequential_1_eff_297NumDims] = PadGraph1052(this, sequential_1_eff_299, sequential_1_eff_299NumDims, true);
            sequential_1_eff_297 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_297, [3 4 2 1], 4);

            sequential_1_eff_297 = dlarray(single(sequential_1_eff_297), 'SSCB');
        end

        function [sequential_1_eff_297, sequential_1_eff_297NumDims1053] = PadGraph1052(this, sequential_1_eff_299, sequential_1_eff_299NumDims, Training)

            % Execute the operators:
            % Pad:
            [sequential_1_eff_297, sequential_1_eff_297NumDims] = dr_classifier_efficientnetb0.ops.onnxPad(sequential_1_eff_299, this.Vars.pad_const__444, 0, 'constant', dlarray([0:sequential_1_eff_299NumDims]'), sequential_1_eff_299NumDims);

            % Set graph output arguments
            sequential_1_eff_297NumDims1053 = sequential_1_eff_297NumDims;

        end

    end

end