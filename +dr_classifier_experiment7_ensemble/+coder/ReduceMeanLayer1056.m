classdef ReduceMeanLayer1056 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1056(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_experiment7_ensemble.ReduceMeanLayer1056(cgInstance.Name);
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
        function this = ReduceMeanLayer1056(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'x_models_0_block_149'};
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

        function [x_models_0_block_149] = predict(this, x_models_0_block_143__)
            if isdlarray(x_models_0_block_143__)
                x_models_0_block_143_ = stripdims(x_models_0_block_143__);
            else
                x_models_0_block_143_ = x_models_0_block_143__;
            end
            x_models_0_block_143NumDims = 4;
            x_models_0_block_143 = dr_classifier_experiment7_ensemble.coder.ops.permuteInputVar(x_models_0_block_143_, [4 3 1 2], 4);

            [x_models_0_block_149__, x_models_0_block_149NumDims__] = ReduceMeanGraph1168(this, x_models_0_block_143, x_models_0_block_143NumDims, false);
            x_models_0_block_149_ = dr_classifier_experiment7_ensemble.coder.ops.permuteOutputVar(x_models_0_block_149__, [3 4 2 1], 4);

            x_models_0_block_149 = dlarray(single(x_models_0_block_149_), 'SSCB');
        end

        function [x_models_0_block_149, x_models_0_block_149NumDims1170] = ReduceMeanGraph1168(this, x_models_0_block_143, x_models_0_block_143NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims1112 = dr_classifier_experiment7_ensemble.coder.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1169, coder.const(x_models_0_block_143NumDims));
            xReduced1113 = mean(x_models_0_block_143, dims1112);
            x_models_0_block_149 = xReduced1113;
            x_models_0_block_149NumDims = coder.const(x_models_0_block_143NumDims);

            % Set graph output arguments
            x_models_0_block_149NumDims1170 = coder.const(x_models_0_block_149NumDims);

        end

    end

end