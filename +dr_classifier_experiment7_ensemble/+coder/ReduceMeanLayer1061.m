classdef ReduceMeanLayer1061 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1061(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_experiment7_ensemble.ReduceMeanLayer1061(cgInstance.Name);
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
        function this = ReduceMeanLayer1061(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'x_models_0_block_223'};
            if isstruct(mlInstance.Vars)
                names = fieldnames(mlInstance.Vars);
                for i=1:numel(names)
                    fieldname = names{i};
                    this.Vars.(fieldname) = dr_classifier_experiment7_ensemble.coder.ops.extractIfDlarray(mlInstance.Vars.(fieldname));
                end
            else
                this.Vars = [];
            end

            this.NumDims = mlInstance.NumDims;
        end

        function [x_models_0_block_223] = predict(this, x_models_0_block_217__)
            if isdlarray(x_models_0_block_217__)
                x_models_0_block_217_ = stripdims(x_models_0_block_217__);
            else
                x_models_0_block_217_ = x_models_0_block_217__;
            end
            x_models_0_block_217NumDims = 4;
            x_models_0_block_217 = dr_classifier_experiment7_ensemble.coder.ops.permuteInputVar(x_models_0_block_217_, [4 3 1 2], 4);

            [x_models_0_block_223__, x_models_0_block_223NumDims__] = ReduceMeanGraph1183(this, x_models_0_block_217, x_models_0_block_217NumDims, false);
            x_models_0_block_223_ = dr_classifier_experiment7_ensemble.coder.ops.permuteOutputVar(x_models_0_block_223__, [3 4 2 1], 4);

            x_models_0_block_223 = dlarray(single(x_models_0_block_223_), 'SSCB');
        end

        function [x_models_0_block_223, x_models_0_block_223NumDims1185] = ReduceMeanGraph1183(this, x_models_0_block_217, x_models_0_block_217NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims1122 = dr_classifier_experiment7_ensemble.coder.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1184, coder.const(x_models_0_block_217NumDims));
            xReduced1123 = mean(x_models_0_block_217, dims1122);
            x_models_0_block_223 = xReduced1123;
            x_models_0_block_223NumDims = coder.const(x_models_0_block_217NumDims);

            % Set graph output arguments
            x_models_0_block_223NumDims1185 = coder.const(x_models_0_block_223NumDims);

        end

    end

end