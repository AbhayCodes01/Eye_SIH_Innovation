classdef ReshapeLayer1005 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_efficientnetb0.coder.ReshapeLayer1005(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_efficientnetb0.ReshapeLayer1005(cgInstance.Name);
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
        function this = ReshapeLayer1005(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'sequential_1_effi_37'};
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

        function [sequential_1_effi_37] = predict(this, sequential_1_effi_46__)
            if isdlarray(sequential_1_effi_46__)
                sequential_1_effi_46_ = stripdims(sequential_1_effi_46__);
            else
                sequential_1_effi_46_ = sequential_1_effi_46__;
            end
            sequential_1_effi_46NumDims = 4;
            sequential_1_effi_46 = dr_classifier_efficientnetb0.coder.ops.permuteInputVar(sequential_1_effi_46_, [4 3 1 2], 4);

            [sequential_1_effi_37__, sequential_1_effi_37NumDims__] = ReshapeGraph1010(this, sequential_1_effi_46, sequential_1_effi_46NumDims, false);
            sequential_1_effi_37_ = dr_classifier_efficientnetb0.coder.ops.permuteOutputVar(sequential_1_effi_37__, [3 4 2 1], 4);

            sequential_1_effi_37 = dlarray(single(sequential_1_effi_37_), 'SSCB');
        end

        function [sequential_1_effi_37, sequential_1_effi_37NumDims1011] = ReshapeGraph1010(this, sequential_1_effi_46, sequential_1_effi_46NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape1003, sequential_1_effi_37NumDims] = dr_classifier_efficientnetb0.coder.ops.prepareReshapeArgs(sequential_1_effi_46, this.Vars.new_shape__1113, coder.const(sequential_1_effi_46NumDims), 0);
            sequential_1_effi_37 = reshape(sequential_1_effi_46, shape1003{:});

            % Set graph output arguments
            sequential_1_effi_37NumDims1011 = coder.const(sequential_1_effi_37NumDims);

        end

    end

end