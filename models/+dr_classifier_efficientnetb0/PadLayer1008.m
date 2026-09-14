classdef PadLayer1008 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.PadLayer1008';
        end
    end


    methods
        function this = PadLayer1008(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_effi_82'};
        end

        function [sequential_1_effi_82] = predict(this, sequential_1_effi_84)
            if isdlarray(sequential_1_effi_84)
                sequential_1_effi_84 = stripdims(sequential_1_effi_84);
            end
            sequential_1_effi_84NumDims = 4;
            sequential_1_effi_84 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_effi_84, [4 3 1 2], 4);

            [sequential_1_effi_82, sequential_1_effi_82NumDims] = PadGraph1016(this, sequential_1_effi_84, sequential_1_effi_84NumDims, false);
            sequential_1_effi_82 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_82, [3 4 2 1], 4);

            sequential_1_effi_82 = dlarray(single(sequential_1_effi_82), 'SSCB');
        end

        function [sequential_1_effi_82] = forward(this, sequential_1_effi_84)
            if isdlarray(sequential_1_effi_84)
                sequential_1_effi_84 = stripdims(sequential_1_effi_84);
            end
            sequential_1_effi_84NumDims = 4;
            sequential_1_effi_84 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_effi_84, [4 3 1 2], 4);

            [sequential_1_effi_82, sequential_1_effi_82NumDims] = PadGraph1016(this, sequential_1_effi_84, sequential_1_effi_84NumDims, true);
            sequential_1_effi_82 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_82, [3 4 2 1], 4);

            sequential_1_effi_82 = dlarray(single(sequential_1_effi_82), 'SSCB');
        end

        function [sequential_1_effi_82, sequential_1_effi_82NumDims1017] = PadGraph1016(this, sequential_1_effi_84, sequential_1_effi_84NumDims, Training)

            % Execute the operators:
            % Pad:
            [sequential_1_effi_82, sequential_1_effi_82NumDims] = dr_classifier_efficientnetb0.ops.onnxPad(sequential_1_effi_84, this.Vars.pad_const__444, 0, 'constant', dlarray([0:sequential_1_effi_84NumDims]'), sequential_1_effi_84NumDims);

            % Set graph output arguments
            sequential_1_effi_82NumDims1017 = sequential_1_effi_82NumDims;

        end

    end

end