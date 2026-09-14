classdef ReduceMeanLayer1040 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1040(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_experiment7_ensemble.ReduceMeanLayer1040(cgInstance.Name);
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
        function this = ReduceMeanLayer1040(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'x_models_1_block_252'};
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

        function [x_models_1_block_252] = predict(this, x_models_1_block_246__)
            if isdlarray(x_models_1_block_246__)
                x_models_1_block_246_ = stripdims(x_models_1_block_246__);
            else
                x_models_1_block_246_ = x_models_1_block_246__;
            end
            x_models_1_block_246NumDims = 4;
            x_models_1_block_246 = dr_classifier_experiment7_ensemble.coder.ops.permuteInputVar(x_models_1_block_246_, [4 3 1 2], 4);

            [x_models_1_block_252__, x_models_1_block_252NumDims__] = ReduceMeanGraph1120(this, x_models_1_block_246, x_models_1_block_246NumDims, false);
            x_models_1_block_252_ = dr_classifier_experiment7_ensemble.coder.ops.permuteOutputVar(x_models_1_block_252__, [3 4 2 1], 4);

            x_models_1_block_252 = dlarray(single(x_models_1_block_252_), 'SSCB');
        end

        function [x_models_1_block_252, x_models_1_block_252NumDims1122] = ReduceMeanGraph1120(this, x_models_1_block_246, x_models_1_block_246NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims1080 = dr_classifier_experiment7_ensemble.coder.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1121, coder.const(x_models_1_block_246NumDims));
            xReduced1081 = mean(x_models_1_block_246, dims1080);
            x_models_1_block_252 = xReduced1081;
            x_models_1_block_252NumDims = coder.const(x_models_1_block_246NumDims);

            % Set graph output arguments
            x_models_1_block_252NumDims1122 = coder.const(x_models_1_block_252NumDims);

        end

    end

end