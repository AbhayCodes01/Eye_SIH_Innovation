classdef ReduceMeanLayer1066 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1066(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_experiment7_ensemble.ReduceMeanLayer1066(cgInstance.Name);
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
        function this = ReduceMeanLayer1066(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'x_models_0_block_297'};
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

        function [x_models_0_block_297] = predict(this, x_models_0_block_291__)
            if isdlarray(x_models_0_block_291__)
                x_models_0_block_291_ = stripdims(x_models_0_block_291__);
            else
                x_models_0_block_291_ = x_models_0_block_291__;
            end
            x_models_0_block_291NumDims = 4;
            x_models_0_block_291 = dr_classifier_experiment7_ensemble.coder.ops.permuteInputVar(x_models_0_block_291_, [4 3 1 2], 4);

            [x_models_0_block_297__, x_models_0_block_297NumDims__] = ReduceMeanGraph1198(this, x_models_0_block_291, x_models_0_block_291NumDims, false);
            x_models_0_block_297_ = dr_classifier_experiment7_ensemble.coder.ops.permuteOutputVar(x_models_0_block_297__, [3 4 2 1], 4);

            x_models_0_block_297 = dlarray(single(x_models_0_block_297_), 'SSCB');
        end

        function [x_models_0_block_297, x_models_0_block_297NumDims1200] = ReduceMeanGraph1198(this, x_models_0_block_291, x_models_0_block_291NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims1132 = dr_classifier_experiment7_ensemble.coder.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1199, coder.const(x_models_0_block_291NumDims));
            xReduced1133 = mean(x_models_0_block_291, dims1132);
            x_models_0_block_297 = xReduced1133;
            x_models_0_block_297NumDims = coder.const(x_models_0_block_291NumDims);

            % Set graph output arguments
            x_models_0_block_297NumDims1200 = coder.const(x_models_0_block_297NumDims);

        end

    end

end