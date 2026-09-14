classdef PadLayer1013 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_efficientnetb0.coder.PadLayer1013(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_efficientnetb0.PadLayer1013(cgInstance.Name);
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
        function this = PadLayer1013(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'sequential_1_eff_136'};
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

        function [sequential_1_eff_136] = predict(this, sequential_1_eff_138__)
            if isdlarray(sequential_1_eff_138__)
                sequential_1_eff_138_ = stripdims(sequential_1_eff_138__);
            else
                sequential_1_eff_138_ = sequential_1_eff_138__;
            end
            sequential_1_eff_138NumDims = 4;
            sequential_1_eff_138 = dr_classifier_efficientnetb0.coder.ops.permuteInputVar(sequential_1_eff_138_, [4 3 1 2], 4);

            [sequential_1_eff_136__, sequential_1_eff_136NumDims__] = PadGraph1026(this, sequential_1_eff_138, sequential_1_eff_138NumDims, false);
            sequential_1_eff_136_ = dr_classifier_efficientnetb0.coder.ops.permuteOutputVar(sequential_1_eff_136__, [3 4 2 1], 4);

            sequential_1_eff_136 = dlarray(single(sequential_1_eff_136_), 'SSCB');
        end

        function [sequential_1_eff_136, sequential_1_eff_136NumDims1027] = PadGraph1026(this, sequential_1_eff_138, sequential_1_eff_138NumDims, Training)

            % Execute the operators:
            % Pad:
            [sequential_1_eff_136, sequential_1_eff_136NumDims] = dr_classifier_efficientnetb0.coder.ops.onnxPad(sequential_1_eff_138, this.Vars.pad_const__51, 0, 'constant', [0:coder.const(sequential_1_eff_138NumDims)]', coder.const(sequential_1_eff_138NumDims));

            % Set graph output arguments
            sequential_1_eff_136NumDims1027 = coder.const(sequential_1_eff_136NumDims);

        end

    end

end