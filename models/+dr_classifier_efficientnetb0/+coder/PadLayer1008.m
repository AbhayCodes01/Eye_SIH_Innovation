classdef PadLayer1008 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_efficientnetb0.coder.PadLayer1008(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_efficientnetb0.PadLayer1008(cgInstance.Name);
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
        function this = PadLayer1008(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'sequential_1_effi_82'};
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

        function [sequential_1_effi_82] = predict(this, sequential_1_effi_84__)
            if isdlarray(sequential_1_effi_84__)
                sequential_1_effi_84_ = stripdims(sequential_1_effi_84__);
            else
                sequential_1_effi_84_ = sequential_1_effi_84__;
            end
            sequential_1_effi_84NumDims = 4;
            sequential_1_effi_84 = dr_classifier_efficientnetb0.coder.ops.permuteInputVar(sequential_1_effi_84_, [4 3 1 2], 4);

            [sequential_1_effi_82__, sequential_1_effi_82NumDims__] = PadGraph1016(this, sequential_1_effi_84, sequential_1_effi_84NumDims, false);
            sequential_1_effi_82_ = dr_classifier_efficientnetb0.coder.ops.permuteOutputVar(sequential_1_effi_82__, [3 4 2 1], 4);

            sequential_1_effi_82 = dlarray(single(sequential_1_effi_82_), 'SSCB');
        end

        function [sequential_1_effi_82, sequential_1_effi_82NumDims1017] = PadGraph1016(this, sequential_1_effi_84, sequential_1_effi_84NumDims, Training)

            % Execute the operators:
            % Pad:
            [sequential_1_effi_82, sequential_1_effi_82NumDims] = dr_classifier_efficientnetb0.coder.ops.onnxPad(sequential_1_effi_84, this.Vars.pad_const__444, 0, 'constant', [0:coder.const(sequential_1_effi_84NumDims)]', coder.const(sequential_1_effi_84NumDims));

            % Set graph output arguments
            sequential_1_effi_82NumDims1017 = coder.const(sequential_1_effi_82NumDims);

        end

    end

end