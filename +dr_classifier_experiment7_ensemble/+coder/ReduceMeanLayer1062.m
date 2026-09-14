classdef ReduceMeanLayer1062 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1062(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_experiment7_ensemble.ReduceMeanLayer1062(cgInstance.Name);
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
        function this = ReduceMeanLayer1062(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'x_models_0_block_237'};
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

        function [x_models_0_block_237] = predict(this, x_models_0_block_231__)
            if isdlarray(x_models_0_block_231__)
                x_models_0_block_231_ = stripdims(x_models_0_block_231__);
            else
                x_models_0_block_231_ = x_models_0_block_231__;
            end
            x_models_0_block_231NumDims = 4;
            x_models_0_block_231 = dr_classifier_experiment7_ensemble.coder.ops.permuteInputVar(x_models_0_block_231_, [4 3 1 2], 4);

            [x_models_0_block_237__, x_models_0_block_237NumDims__] = ReduceMeanGraph1186(this, x_models_0_block_231, x_models_0_block_231NumDims, false);
            x_models_0_block_237_ = dr_classifier_experiment7_ensemble.coder.ops.permuteOutputVar(x_models_0_block_237__, [3 4 2 1], 4);

            x_models_0_block_237 = dlarray(single(x_models_0_block_237_), 'SSCB');
        end

        function [x_models_0_block_237, x_models_0_block_237NumDims1188] = ReduceMeanGraph1186(this, x_models_0_block_231, x_models_0_block_231NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims1124 = dr_classifier_experiment7_ensemble.coder.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1187, coder.const(x_models_0_block_231NumDims));
            xReduced1125 = mean(x_models_0_block_231, dims1124);
            x_models_0_block_237 = xReduced1125;
            x_models_0_block_237NumDims = coder.const(x_models_0_block_231NumDims);

            % Set graph output arguments
            x_models_0_block_237NumDims1188 = coder.const(x_models_0_block_237NumDims);

        end

    end

end