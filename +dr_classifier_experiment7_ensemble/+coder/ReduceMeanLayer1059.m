classdef ReduceMeanLayer1059 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1059(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_experiment7_ensemble.ReduceMeanLayer1059(cgInstance.Name);
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
        function this = ReduceMeanLayer1059(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'x_models_0_block_193'};
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

        function [x_models_0_block_193] = predict(this, x_models_0_block_187__)
            if isdlarray(x_models_0_block_187__)
                x_models_0_block_187_ = stripdims(x_models_0_block_187__);
            else
                x_models_0_block_187_ = x_models_0_block_187__;
            end
            x_models_0_block_187NumDims = 4;
            x_models_0_block_187 = dr_classifier_experiment7_ensemble.coder.ops.permuteInputVar(x_models_0_block_187_, [4 3 1 2], 4);

            [x_models_0_block_193__, x_models_0_block_193NumDims__] = ReduceMeanGraph1177(this, x_models_0_block_187, x_models_0_block_187NumDims, false);
            x_models_0_block_193_ = dr_classifier_experiment7_ensemble.coder.ops.permuteOutputVar(x_models_0_block_193__, [3 4 2 1], 4);

            x_models_0_block_193 = dlarray(single(x_models_0_block_193_), 'SSCB');
        end

        function [x_models_0_block_193, x_models_0_block_193NumDims1179] = ReduceMeanGraph1177(this, x_models_0_block_187, x_models_0_block_187NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims1118 = dr_classifier_experiment7_ensemble.coder.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1178, coder.const(x_models_0_block_187NumDims));
            xReduced1119 = mean(x_models_0_block_187, dims1118);
            x_models_0_block_193 = xReduced1119;
            x_models_0_block_193NumDims = coder.const(x_models_0_block_187NumDims);

            % Set graph output arguments
            x_models_0_block_193NumDims1179 = coder.const(x_models_0_block_193NumDims);

        end

    end

end