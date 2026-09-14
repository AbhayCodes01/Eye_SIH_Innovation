classdef PadLayer1003 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.PadLayer1003';
        end
    end


    methods
        function this = PadLayer1003(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_effi_28'};
        end

        function [sequential_1_effi_28] = predict(this, sequential_1_effi_30)
            if isdlarray(sequential_1_effi_30)
                sequential_1_effi_30 = stripdims(sequential_1_effi_30);
            end
            sequential_1_effi_30NumDims = 4;
            sequential_1_effi_30 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_effi_30, [4 3 1 2], 4);

            [sequential_1_effi_28, sequential_1_effi_28NumDims] = PadGraph1006(this, sequential_1_effi_30, sequential_1_effi_30NumDims, false);
            sequential_1_effi_28 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_28, [3 4 2 1], 4);

            sequential_1_effi_28 = dlarray(single(sequential_1_effi_28), 'SSCB');
        end

        function [sequential_1_effi_28] = forward(this, sequential_1_effi_30)
            if isdlarray(sequential_1_effi_30)
                sequential_1_effi_30 = stripdims(sequential_1_effi_30);
            end
            sequential_1_effi_30NumDims = 4;
            sequential_1_effi_30 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_effi_30, [4 3 1 2], 4);

            [sequential_1_effi_28, sequential_1_effi_28NumDims] = PadGraph1006(this, sequential_1_effi_30, sequential_1_effi_30NumDims, true);
            sequential_1_effi_28 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_28, [3 4 2 1], 4);

            sequential_1_effi_28 = dlarray(single(sequential_1_effi_28), 'SSCB');
        end

        function [sequential_1_effi_28, sequential_1_effi_28NumDims1007] = PadGraph1006(this, sequential_1_effi_30, sequential_1_effi_30NumDims, Training)

            % Execute the operators:
            % Pad:
            [sequential_1_effi_28, sequential_1_effi_28NumDims] = dr_classifier_efficientnetb0.ops.onnxPad(sequential_1_effi_30, this.Vars.pad_const__51, 0, 'constant', dlarray([0:sequential_1_effi_30NumDims]'), sequential_1_effi_30NumDims);

            % Set graph output arguments
            sequential_1_effi_28NumDims1007 = sequential_1_effi_28NumDims;

        end

    end

end