classdef ReduceMeanLayer1064 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1064(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_experiment7_ensemble.ReduceMeanLayer1064(cgInstance.Name);
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
        function this = ReduceMeanLayer1064(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'x_models_0_block_267'};
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

        function [x_models_0_block_267] = predict(this, x_models_0_block_261__)
            if isdlarray(x_models_0_block_261__)
                x_models_0_block_261_ = stripdims(x_models_0_block_261__);
            else
                x_models_0_block_261_ = x_models_0_block_261__;
            end
            x_models_0_block_261NumDims = 4;
            x_models_0_block_261 = dr_classifier_experiment7_ensemble.coder.ops.permuteInputVar(x_models_0_block_261_, [4 3 1 2], 4);

            [x_models_0_block_267__, x_models_0_block_267NumDims__] = ReduceMeanGraph1192(this, x_models_0_block_261, x_models_0_block_261NumDims, false);
            x_models_0_block_267_ = dr_classifier_experiment7_ensemble.coder.ops.permuteOutputVar(x_models_0_block_267__, [3 4 2 1], 4);

            x_models_0_block_267 = dlarray(single(x_models_0_block_267_), 'SSCB');
        end

        function [x_models_0_block_267, x_models_0_block_267NumDims1194] = ReduceMeanGraph1192(this, x_models_0_block_261, x_models_0_block_261NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims1128 = dr_classifier_experiment7_ensemble.coder.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1193, coder.const(x_models_0_block_261NumDims));
            xReduced1129 = mean(x_models_0_block_261, dims1128);
            x_models_0_block_267 = xReduced1129;
            x_models_0_block_267NumDims = coder.const(x_models_0_block_261NumDims);

            % Set graph output arguments
            x_models_0_block_267NumDims1194 = coder.const(x_models_0_block_267NumDims);

        end

    end

end