classdef ReduceMeanLayer1006 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1006(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_experiment7_ensemble.ReduceMeanLayer1006(cgInstance.Name);
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
        function this = ReduceMeanLayer1006(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'x_models_2_blocks_90'};
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

        function [x_models_2_blocks_90] = predict(this, x_models_2_blocks_84__)
            if isdlarray(x_models_2_blocks_84__)
                x_models_2_blocks_84_ = stripdims(x_models_2_blocks_84__);
            else
                x_models_2_blocks_84_ = x_models_2_blocks_84__;
            end
            x_models_2_blocks_84NumDims = 4;
            x_models_2_blocks_84 = dr_classifier_experiment7_ensemble.coder.ops.permuteInputVar(x_models_2_blocks_84_, [4 3 1 2], 4);

            [x_models_2_blocks_90__, x_models_2_blocks_90NumDims__] = ReduceMeanGraph1018(this, x_models_2_blocks_84, x_models_2_blocks_84NumDims, false);
            x_models_2_blocks_90_ = dr_classifier_experiment7_ensemble.coder.ops.permuteOutputVar(x_models_2_blocks_90__, [3 4 2 1], 4);

            x_models_2_blocks_90 = dlarray(single(x_models_2_blocks_90_), 'SSCB');
        end

        function [x_models_2_blocks_90, x_models_2_blocks_90NumDims1020] = ReduceMeanGraph1018(this, x_models_2_blocks_84, x_models_2_blocks_84NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims1012 = dr_classifier_experiment7_ensemble.coder.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1019, coder.const(x_models_2_blocks_84NumDims));
            xReduced1013 = mean(x_models_2_blocks_84, dims1012);
            x_models_2_blocks_90 = xReduced1013;
            x_models_2_blocks_90NumDims = coder.const(x_models_2_blocks_84NumDims);

            % Set graph output arguments
            x_models_2_blocks_90NumDims1020 = coder.const(x_models_2_blocks_90NumDims);

        end

    end

end