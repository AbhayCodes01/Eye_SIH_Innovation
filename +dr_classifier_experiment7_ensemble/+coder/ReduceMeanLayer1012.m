classdef ReduceMeanLayer1012 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1012(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_experiment7_ensemble.ReduceMeanLayer1012(cgInstance.Name);
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
        function this = ReduceMeanLayer1012(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'x_models_2_block_178'};
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

        function [x_models_2_block_178] = predict(this, x_models_2_block_172__)
            if isdlarray(x_models_2_block_172__)
                x_models_2_block_172_ = stripdims(x_models_2_block_172__);
            else
                x_models_2_block_172_ = x_models_2_block_172__;
            end
            x_models_2_block_172NumDims = 4;
            x_models_2_block_172 = dr_classifier_experiment7_ensemble.coder.ops.permuteInputVar(x_models_2_block_172_, [4 3 1 2], 4);

            [x_models_2_block_178__, x_models_2_block_178NumDims__] = ReduceMeanGraph1036(this, x_models_2_block_172, x_models_2_block_172NumDims, false);
            x_models_2_block_178_ = dr_classifier_experiment7_ensemble.coder.ops.permuteOutputVar(x_models_2_block_178__, [3 4 2 1], 4);

            x_models_2_block_178 = dlarray(single(x_models_2_block_178_), 'SSCB');
        end

        function [x_models_2_block_178, x_models_2_block_178NumDims1038] = ReduceMeanGraph1036(this, x_models_2_block_172, x_models_2_block_172NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims1024 = dr_classifier_experiment7_ensemble.coder.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1037, coder.const(x_models_2_block_172NumDims));
            xReduced1025 = mean(x_models_2_block_172, dims1024);
            x_models_2_block_178 = xReduced1025;
            x_models_2_block_178NumDims = coder.const(x_models_2_block_172NumDims);

            % Set graph output arguments
            x_models_2_block_178NumDims1038 = coder.const(x_models_2_block_178NumDims);

        end

    end

end