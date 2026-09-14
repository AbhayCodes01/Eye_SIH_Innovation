classdef PadLayer1003 < nnet.layer.Layer & nnet.layer.Formattable
    % A custom layer auto-generated while importing an ONNX network.
    %#codegen

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
        % Specify the properties of the class that will not be modified
        % after the first assignment.
        function p = matlabCodegenNontunableProperties(~)
            p = {
                % Constants, i.e., Vars, NumDims and all learnables and states
                'Vars'
                'NumDims'
                };
        end
    end


    methods(Static, Hidden)
        % Instantiate a codegenable layer instance from a MATLAB layer instance
        function this_cg = matlabCodegenToRedirected(mlInstance)
            this_cg = dr_classifier_efficientnetb0.coder.PadLayer1003(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_efficientnetb0.PadLayer1003(cgInstance.Name);
            if isstruct(cgInstance.Vars)
                names = fieldnames(cgInstance.Vars);
                for i=1:numel(names)
                    fieldname = names{i};
                    this_ml.Vars.(fieldname) = dlarray(cgInstance.Vars.(fieldname));
                end
            else
                this_ml.Vars = [];
            end
            this_ml.NumDims = cgInstance.NumDims;
        end
    end

    methods
        function this = PadLayer1003(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'sequential_1_effi_28'};
            if isstruct(mlInstance.Vars)
                names = fieldnames(mlInstance.Vars);
                for i=1:numel(names)
                    fieldname = names{i};
                    this.Vars.(fieldname) = dr_classifier_efficientnetb0.coder.ops.extractIfDlarray(mlInstance.Vars.(fieldname));
                end
            else
                this.Vars = [];
            end

            this.NumDims = mlInstance.NumDims;
        end

        function [sequential_1_effi_28] = predict(this, sequential_1_effi_30__)
            if isdlarray(sequential_1_effi_30__)
                sequential_1_effi_30_ = stripdims(sequential_1_effi_30__);
            else
                sequential_1_effi_30_ = sequential_1_effi_30__;
            end
            sequential_1_effi_30NumDims = 4;
            sequential_1_effi_30 = dr_classifier_efficientnetb0.coder.ops.permuteInputVar(sequential_1_effi_30_, [4 3 1 2], 4);

            [sequential_1_effi_28__, sequential_1_effi_28NumDims__] = PadGraph1006(this, sequential_1_effi_30, sequential_1_effi_30NumDims, false);
            sequential_1_effi_28_ = dr_classifier_efficientnetb0.coder.ops.permuteOutputVar(sequential_1_effi_28__, [3 4 2 1], 4);

            sequential_1_effi_28 = dlarray(single(sequential_1_effi_28_), 'SSCB');
        end

        function [sequential_1_effi_28, sequential_1_effi_28NumDims1007] = PadGraph1006(this, sequential_1_effi_30, sequential_1_effi_30NumDims, Training)

            % Execute the operators:
            % Pad:
            [sequential_1_effi_28, sequential_1_effi_28NumDims] = dr_classifier_efficientnetb0.coder.ops.onnxPad(sequential_1_effi_30, this.Vars.pad_const__51, 0, 'constant', [0:coder.const(sequential_1_effi_30NumDims)]', coder.const(sequential_1_effi_30NumDims));

            % Set graph output arguments
            sequential_1_effi_28NumDims1007 = coder.const(sequential_1_effi_28NumDims);

        end

    end

end