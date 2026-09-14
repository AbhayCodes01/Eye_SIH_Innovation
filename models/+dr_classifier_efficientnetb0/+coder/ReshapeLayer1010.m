classdef ReshapeLayer1010 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_efficientnetb0.coder.ReshapeLayer1010(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_efficientnetb0.ReshapeLayer1010(cgInstance.Name);
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
        function this = ReshapeLayer1010(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'sequential_1_effi_91'};
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

        function [sequential_1_effi_91] = predict(this, sequential_1_eff_100__)
            if isdlarray(sequential_1_eff_100__)
                sequential_1_eff_100_ = stripdims(sequential_1_eff_100__);
            else
                sequential_1_eff_100_ = sequential_1_eff_100__;
            end
            sequential_1_eff_100NumDims = 4;
            sequential_1_eff_100 = dr_classifier_efficientnetb0.coder.ops.permuteInputVar(sequential_1_eff_100_, [4 3 1 2], 4);

            [sequential_1_effi_91__, sequential_1_effi_91NumDims__] = ReshapeGraph1020(this, sequential_1_eff_100, sequential_1_eff_100NumDims, false);
            sequential_1_effi_91_ = dr_classifier_efficientnetb0.coder.ops.permuteOutputVar(sequential_1_effi_91__, [3 4 2 1], 4);

            sequential_1_effi_91 = dlarray(single(sequential_1_effi_91_), 'SSCB');
        end

        function [sequential_1_effi_91, sequential_1_effi_91NumDims1021] = ReshapeGraph1020(this, sequential_1_eff_100, sequential_1_eff_100NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape1007, sequential_1_effi_91NumDims] = dr_classifier_efficientnetb0.coder.ops.prepareReshapeArgs(sequential_1_eff_100, this.Vars.new_shape__1132, coder.const(sequential_1_eff_100NumDims), 0);
            sequential_1_effi_91 = reshape(sequential_1_eff_100, shape1007{:});

            % Set graph output arguments
            sequential_1_effi_91NumDims1021 = coder.const(sequential_1_effi_91NumDims);

        end

    end

end