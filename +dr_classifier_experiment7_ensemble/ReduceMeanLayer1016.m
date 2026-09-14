classdef ReduceMeanLayer1016 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1016';
        end
    end


    methods
        function this = ReduceMeanLayer1016(name)
            this.Name = name;
            this.OutputNames = {'x_models_2_block_237'};
        end

        function [x_models_2_block_237] = predict(this, x_models_2_block_231)
            if isdlarray(x_models_2_block_231)
                x_models_2_block_231 = stripdims(x_models_2_block_231);
            end
            x_models_2_block_231NumDims = 4;
            x_models_2_block_231 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_2_block_231, [4 3 1 2], 4);

            [x_models_2_block_237, x_models_2_block_237NumDims] = ReduceMeanGraph1048(this, x_models_2_block_231, x_models_2_block_231NumDims, false);
            x_models_2_block_237 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_2_block_237, [3 4 2 1], 4);

            x_models_2_block_237 = dlarray(single(x_models_2_block_237), 'SSCB');
        end

        function [x_models_2_block_237] = forward(this, x_models_2_block_231)
            if isdlarray(x_models_2_block_231)
                x_models_2_block_231 = stripdims(x_models_2_block_231);
            end
            x_models_2_block_231NumDims = 4;
            x_models_2_block_231 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_2_block_231, [4 3 1 2], 4);

            [x_models_2_block_237, x_models_2_block_237NumDims] = ReduceMeanGraph1048(this, x_models_2_block_231, x_models_2_block_231NumDims, true);
            x_models_2_block_237 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_2_block_237, [3 4 2 1], 4);

            x_models_2_block_237 = dlarray(single(x_models_2_block_237), 'SSCB');
        end

        function [x_models_2_block_237, x_models_2_block_237NumDims1050] = ReduceMeanGraph1048(this, x_models_2_block_231, x_models_2_block_231NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1049, x_models_2_block_231NumDims);
            xMean = mean(x_models_2_block_231, dims);
            x_models_2_block_237 = xMean;
            x_models_2_block_237NumDims = x_models_2_block_231NumDims;

            % Set graph output arguments
            x_models_2_block_237NumDims1050 = x_models_2_block_237NumDims;

        end

    end

end