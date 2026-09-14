classdef ReshapeLayer1007 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_efficientnetb0.coder.ReshapeLayer1007(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_efficientnetb0.ReshapeLayer1007(cgInstance.Name);
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
        function this = ReshapeLayer1007(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'sequential_1_effi_64'};
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

        function [sequential_1_effi_64] = predict(this, sequential_1_effi_73__)
            if isdlarray(sequential_1_effi_73__)
                sequential_1_effi_73_ = stripdims(sequential_1_effi_73__);
            else
                sequential_1_effi_73_ = sequential_1_effi_73__;
            end
            sequential_1_effi_73NumDims = 4;
            sequential_1_effi_73 = dr_classifier_efficientnetb0.coder.ops.permuteInputVar(sequential_1_effi_73_, [4 3 1 2], 4);

            [sequential_1_effi_64__, sequential_1_effi_64NumDims__] = ReshapeGraph1014(this, sequential_1_effi_73, sequential_1_effi_73NumDims, false);
            sequential_1_effi_64_ = dr_classifier_efficientnetb0.coder.ops.permuteOutputVar(sequential_1_effi_64__, [3 4 2 1], 4);

            sequential_1_effi_64 = dlarray(single(sequential_1_effi_64_), 'SSCB');
        end

        function [sequential_1_effi_64, sequential_1_effi_64NumDims1015] = ReshapeGraph1014(this, sequential_1_effi_73, sequential_1_effi_73NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape1005, sequential_1_effi_64NumDims] = dr_classifier_efficientnetb0.coder.ops.prepareReshapeArgs(sequential_1_effi_73, this.Vars.new_shape__1132, coder.const(sequential_1_effi_73NumDims), 0);
            sequential_1_effi_64 = reshape(sequential_1_effi_73, shape1005{:});

            % Set graph output arguments
            sequential_1_effi_64NumDims1015 = coder.const(sequential_1_effi_64NumDims);

        end

    end

end