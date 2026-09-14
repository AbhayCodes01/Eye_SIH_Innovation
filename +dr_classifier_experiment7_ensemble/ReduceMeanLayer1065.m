classdef ReduceMeanLayer1065 < nnet.layer.Layer & nnet.layer.Formattable
    % A custom layer auto-generated while importing an ONNX network.

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
        % Specify the path to the class that will be used for codegen
        function name = matlabCodegenRedirect(~)
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1065';
        end
    end


    methods
        function this = ReduceMeanLayer1065(name)
            this.Name = name;
            this.OutputNames = {'x_models_0_block_282'};
        end

        function [x_models_0_block_282] = predict(this, x_models_0_block_276)
            if isdlarray(x_models_0_block_276)
                x_models_0_block_276 = stripdims(x_models_0_block_276);
            end
            x_models_0_block_276NumDims = 4;
            x_models_0_block_276 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_0_block_276, [4 3 1 2], 4);

            [x_models_0_block_282, x_models_0_block_282NumDims] = ReduceMeanGraph1195(this, x_models_0_block_276, x_models_0_block_276NumDims, false);
            x_models_0_block_282 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_0_block_282, [3 4 2 1], 4);

            x_models_0_block_282 = dlarray(single(x_models_0_block_282), 'SSCB');
        end

        function [x_models_0_block_282] = forward(this, x_models_0_block_276)
            if isdlarray(x_models_0_block_276)
                x_models_0_block_276 = stripdims(x_models_0_block_276);
            end
            x_models_0_block_276NumDims = 4;
            x_models_0_block_276 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_0_block_276, [4 3 1 2], 4);

            [x_models_0_block_282, x_models_0_block_282NumDims] = ReduceMeanGraph1195(this, x_models_0_block_276, x_models_0_block_276NumDims, true);
            x_models_0_block_282 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_0_block_282, [3 4 2 1], 4);

            x_models_0_block_282 = dlarray(single(x_models_0_block_282), 'SSCB');
        end

        function [x_models_0_block_282, x_models_0_block_282NumDims1197] = ReduceMeanGraph1195(this, x_models_0_block_276, x_models_0_block_276NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1196, x_models_0_block_276NumDims);
            xMean = mean(x_models_0_block_276, dims);
            x_models_0_block_282 = xMean;
            x_models_0_block_282NumDims = x_models_0_block_276NumDims;

            % Set graph output arguments
            x_models_0_block_282NumDims1197 = x_models_0_block_282NumDims;

        end

    end

end