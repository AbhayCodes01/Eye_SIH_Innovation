classdef ReduceMeanLayer1007 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1007(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_experiment7_ensemble.ReduceMeanLayer1007(cgInstance.Name);
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
        function this = ReduceMeanLayer1007(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'x_models_2_block_105'};
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

        function [x_models_2_block_105] = predict(this, x_models_2_blocks_99__)
            if isdlarray(x_models_2_blocks_99__)
                x_models_2_blocks_99_ = stripdims(x_models_2_blocks_99__);
            else
                x_models_2_blocks_99_ = x_models_2_blocks_99__;
            end
            x_models_2_blocks_99NumDims = 4;
            x_models_2_blocks_99 = dr_classifier_experiment7_ensemble.coder.ops.permuteInputVar(x_models_2_blocks_99_, [4 3 1 2], 4);

            [x_models_2_block_105__, x_models_2_block_105NumDims__] = ReduceMeanGraph1021(this, x_models_2_blocks_99, x_models_2_blocks_99NumDims, false);
            x_models_2_block_105_ = dr_classifier_experiment7_ensemble.coder.ops.permuteOutputVar(x_models_2_block_105__, [3 4 2 1], 4);

            x_models_2_block_105 = dlarray(single(x_models_2_block_105_), 'SSCB');
        end

        function [x_models_2_block_105, x_models_2_block_105NumDims1023] = ReduceMeanGraph1021(this, x_models_2_blocks_99, x_models_2_blocks_99NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims1014 = dr_classifier_experiment7_ensemble.coder.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1022, coder.const(x_models_2_blocks_99NumDims));
            xReduced1015 = mean(x_models_2_blocks_99, dims1014);
            x_models_2_block_105 = xReduced1015;
            x_models_2_block_105NumDims = coder.const(x_models_2_blocks_99NumDims);

            % Set graph output arguments
            x_models_2_block_105NumDims1023 = coder.const(x_models_2_block_105NumDims);

        end

    end

end