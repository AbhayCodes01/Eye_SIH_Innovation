classdef ReshapeLayer1002 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_efficientnetb0.coder.ReshapeLayer1002(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_efficientnetb0.ReshapeLayer1002(cgInstance.Name);
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
        function this = ReshapeLayer1002(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'sequential_1_effi_10'};
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

        function [sequential_1_effi_10] = predict(this, sequential_1_effi_19__)
            if isdlarray(sequential_1_effi_19__)
                sequential_1_effi_19_ = stripdims(sequential_1_effi_19__);
            else
                sequential_1_effi_19_ = sequential_1_effi_19__;
            end
            sequential_1_effi_19NumDims = 4;
            sequential_1_effi_19 = dr_classifier_efficientnetb0.coder.ops.permuteInputVar(sequential_1_effi_19_, [4 3 1 2], 4);

            [sequential_1_effi_10__, sequential_1_effi_10NumDims__] = ReshapeGraph1004(this, sequential_1_effi_19, sequential_1_effi_19NumDims, false);
            sequential_1_effi_10_ = dr_classifier_efficientnetb0.coder.ops.permuteOutputVar(sequential_1_effi_10__, [3 4 2 1], 4);

            sequential_1_effi_10 = dlarray(single(sequential_1_effi_10_), 'SSCB');
        end

        function [sequential_1_effi_10, sequential_1_effi_10NumDims1005] = ReshapeGraph1004(this, sequential_1_effi_19, sequential_1_effi_19NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape1001, sequential_1_effi_10NumDims] = dr_classifier_efficientnetb0.coder.ops.prepareReshapeArgs(sequential_1_effi_19, this.Vars.new_shape__1104, coder.const(sequential_1_effi_19NumDims), 0);
            sequential_1_effi_10 = reshape(sequential_1_effi_19, shape1001{:});

            % Set graph output arguments
            sequential_1_effi_10NumDims1005 = coder.const(sequential_1_effi_10NumDims);

        end

    end

end