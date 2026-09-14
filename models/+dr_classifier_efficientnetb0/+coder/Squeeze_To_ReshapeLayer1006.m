classdef Squeeze_To_ReshapeLayer1006 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1006(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_efficientnetb0.Squeeze_To_ReshapeLayer1006(cgInstance.Name);
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
        function this = Squeeze_To_ReshapeLayer1006(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'sequential_1_effi_69'};
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

        function [sequential_1_effi_69] = predict(this, sequential_1_effi_74__)
            if isdlarray(sequential_1_effi_74__)
                sequential_1_effi_74_ = stripdims(sequential_1_effi_74__);
            else
                sequential_1_effi_74_ = sequential_1_effi_74__;
            end
            sequential_1_effi_74NumDims = 4;
            sequential_1_effi_74 = dr_classifier_efficientnetb0.coder.ops.permuteInputVar(sequential_1_effi_74_, [4 3 1 2], 4);

            [sequential_1_effi_69__, sequential_1_effi_69NumDims__] = Squeeze_To_ReshapeGraph1012(this, sequential_1_effi_74, sequential_1_effi_74NumDims, false);
            sequential_1_effi_69_ = dr_classifier_efficientnetb0.coder.ops.permuteOutputVar(sequential_1_effi_69__, [3 4 2 1], 4);

            sequential_1_effi_69 = dlarray(single(sequential_1_effi_69_), 'SSCB');
        end

        function [sequential_1_effi_69, sequential_1_effi_69NumDims1013] = Squeeze_To_ReshapeGraph1012(this, sequential_1_effi_74, sequential_1_effi_74NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_effi_75, sequential_1_effi_75NumDims] = dr_classifier_efficientnetb0.coder.ops.onnxSqueeze(sequential_1_effi_74, this.Vars.const_axes__1282, coder.const(sequential_1_effi_74NumDims));

            % Reshape:
            [shape1004, sequential_1_effi_69NumDims] = dr_classifier_efficientnetb0.coder.ops.prepareReshapeArgs(sequential_1_effi_75, this.Vars.new_shape__1130, coder.const(sequential_1_effi_75NumDims), 0);
            sequential_1_effi_69 = reshape(sequential_1_effi_75, shape1004{:});

            % Set graph output arguments
            sequential_1_effi_69NumDims1013 = coder.const(sequential_1_effi_69NumDims);

        end

    end

end