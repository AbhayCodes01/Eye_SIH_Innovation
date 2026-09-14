classdef ReduceMeanLayer1067 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1067(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_experiment7_ensemble.ReduceMeanLayer1067(cgInstance.Name);
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
        function this = ReduceMeanLayer1067(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'x_models_0_block_311'};
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

        function [x_models_0_block_311] = predict(this, x_models_0_block_305__)
            if isdlarray(x_models_0_block_305__)
                x_models_0_block_305_ = stripdims(x_models_0_block_305__);
            else
                x_models_0_block_305_ = x_models_0_block_305__;
            end
            x_models_0_block_305NumDims = 4;
            x_models_0_block_305 = dr_classifier_experiment7_ensemble.coder.ops.permuteInputVar(x_models_0_block_305_, [4 3 1 2], 4);

            [x_models_0_block_311__, x_models_0_block_311NumDims__] = ReduceMeanGraph1201(this, x_models_0_block_305, x_models_0_block_305NumDims, false);
            x_models_0_block_311_ = dr_classifier_experiment7_ensemble.coder.ops.permuteOutputVar(x_models_0_block_311__, [3 4 2 1], 4);

            x_models_0_block_311 = dlarray(single(x_models_0_block_311_), 'SSCB');
        end

        function [x_models_0_block_311, x_models_0_block_311NumDims1203] = ReduceMeanGraph1201(this, x_models_0_block_305, x_models_0_block_305NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims1134 = dr_classifier_experiment7_ensemble.coder.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1202, coder.const(x_models_0_block_305NumDims));
            xReduced1135 = mean(x_models_0_block_305, dims1134);
            x_models_0_block_311 = xReduced1135;
            x_models_0_block_311NumDims = coder.const(x_models_0_block_305NumDims);

            % Set graph output arguments
            x_models_0_block_311NumDims1203 = coder.const(x_models_0_block_311NumDims);

        end

    end

end