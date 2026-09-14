classdef PadLayer1026 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_efficientnetb0.coder.PadLayer1026(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_efficientnetb0.PadLayer1026(cgInstance.Name);
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
        function this = PadLayer1026(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'sequential_1_eff_297'};
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

        function [sequential_1_eff_297] = predict(this, sequential_1_eff_299__)
            if isdlarray(sequential_1_eff_299__)
                sequential_1_eff_299_ = stripdims(sequential_1_eff_299__);
            else
                sequential_1_eff_299_ = sequential_1_eff_299__;
            end
            sequential_1_eff_299NumDims = 4;
            sequential_1_eff_299 = dr_classifier_efficientnetb0.coder.ops.permuteInputVar(sequential_1_eff_299_, [4 3 1 2], 4);

            [sequential_1_eff_297__, sequential_1_eff_297NumDims__] = PadGraph1052(this, sequential_1_eff_299, sequential_1_eff_299NumDims, false);
            sequential_1_eff_297_ = dr_classifier_efficientnetb0.coder.ops.permuteOutputVar(sequential_1_eff_297__, [3 4 2 1], 4);

            sequential_1_eff_297 = dlarray(single(sequential_1_eff_297_), 'SSCB');
        end

        function [sequential_1_eff_297, sequential_1_eff_297NumDims1053] = PadGraph1052(this, sequential_1_eff_299, sequential_1_eff_299NumDims, Training)

            % Execute the operators:
            % Pad:
            [sequential_1_eff_297, sequential_1_eff_297NumDims] = dr_classifier_efficientnetb0.coder.ops.onnxPad(sequential_1_eff_299, this.Vars.pad_const__444, 0, 'constant', [0:coder.const(sequential_1_eff_299NumDims)]', coder.const(sequential_1_eff_299NumDims));

            % Set graph output arguments
            sequential_1_eff_297NumDims1053 = coder.const(sequential_1_eff_297NumDims);

        end

    end

end