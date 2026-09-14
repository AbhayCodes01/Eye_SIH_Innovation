classdef PadLayer1013 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.PadLayer1013';
        end
    end


    methods
        function this = PadLayer1013(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_136'};
        end

        function [sequential_1_eff_136] = predict(this, sequential_1_eff_138)
            if isdlarray(sequential_1_eff_138)
                sequential_1_eff_138 = stripdims(sequential_1_eff_138);
            end
            sequential_1_eff_138NumDims = 4;
            sequential_1_eff_138 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_138, [4 3 1 2], 4);

            [sequential_1_eff_136, sequential_1_eff_136NumDims] = PadGraph1026(this, sequential_1_eff_138, sequential_1_eff_138NumDims, false);
            sequential_1_eff_136 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_136, [3 4 2 1], 4);

            sequential_1_eff_136 = dlarray(single(sequential_1_eff_136), 'SSCB');
        end

        function [sequential_1_eff_136] = forward(this, sequential_1_eff_138)
            if isdlarray(sequential_1_eff_138)
                sequential_1_eff_138 = stripdims(sequential_1_eff_138);
            end
            sequential_1_eff_138NumDims = 4;
            sequential_1_eff_138 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_138, [4 3 1 2], 4);

            [sequential_1_eff_136, sequential_1_eff_136NumDims] = PadGraph1026(this, sequential_1_eff_138, sequential_1_eff_138NumDims, true);
            sequential_1_eff_136 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_136, [3 4 2 1], 4);

            sequential_1_eff_136 = dlarray(single(sequential_1_eff_136), 'SSCB');
        end

        function [sequential_1_eff_136, sequential_1_eff_136NumDims1027] = PadGraph1026(this, sequential_1_eff_138, sequential_1_eff_138NumDims, Training)

            % Execute the operators:
            % Pad:
            [sequential_1_eff_136, sequential_1_eff_136NumDims] = dr_classifier_efficientnetb0.ops.onnxPad(sequential_1_eff_138, this.Vars.pad_const__51, 0, 'constant', dlarray([0:sequential_1_eff_138NumDims]'), sequential_1_eff_138NumDims);

            % Set graph output arguments
            sequential_1_eff_136NumDims1027 = sequential_1_eff_136NumDims;

        end

    end

end