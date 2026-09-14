classdef ReduceMeanLayer1045 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1045(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_experiment7_ensemble.ReduceMeanLayer1045(cgInstance.Name);
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
        function this = ReduceMeanLayer1045(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'x_models_1_block_326'};
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

        function [x_models_1_block_326] = predict(this, x_models_1_block_320__)
            if isdlarray(x_models_1_block_320__)
                x_models_1_block_320_ = stripdims(x_models_1_block_320__);
            else
                x_models_1_block_320_ = x_models_1_block_320__;
            end
            x_models_1_block_320NumDims = 4;
            x_models_1_block_320 = dr_classifier_experiment7_ensemble.coder.ops.permuteInputVar(x_models_1_block_320_, [4 3 1 2], 4);

            [x_models_1_block_326__, x_models_1_block_326NumDims__] = ReduceMeanGraph1135(this, x_models_1_block_320, x_models_1_block_320NumDims, false);
            x_models_1_block_326_ = dr_classifier_experiment7_ensemble.coder.ops.permuteOutputVar(x_models_1_block_326__, [3 4 2 1], 4);

            x_models_1_block_326 = dlarray(single(x_models_1_block_326_), 'SSCB');
        end

        function [x_models_1_block_326, x_models_1_block_326NumDims1137] = ReduceMeanGraph1135(this, x_models_1_block_320, x_models_1_block_320NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims1090 = dr_classifier_experiment7_ensemble.coder.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1136, coder.const(x_models_1_block_320NumDims));
            xReduced1091 = mean(x_models_1_block_320, dims1090);
            x_models_1_block_326 = xReduced1091;
            x_models_1_block_326NumDims = coder.const(x_models_1_block_320NumDims);

            % Set graph output arguments
            x_models_1_block_326NumDims1137 = coder.const(x_models_1_block_326NumDims);

        end

    end

end