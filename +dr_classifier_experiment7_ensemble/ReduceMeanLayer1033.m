classdef ReduceMeanLayer1033 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1033';
        end
    end


    methods
        function this = ReduceMeanLayer1033(name)
            this.Name = name;
            this.OutputNames = {'x_models_1_block_149'};
        end

        function [x_models_1_block_149] = predict(this, x_models_1_block_143)
            if isdlarray(x_models_1_block_143)
                x_models_1_block_143 = stripdims(x_models_1_block_143);
            end
            x_models_1_block_143NumDims = 4;
            x_models_1_block_143 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_1_block_143, [4 3 1 2], 4);

            [x_models_1_block_149, x_models_1_block_149NumDims] = ReduceMeanGraph1099(this, x_models_1_block_143, x_models_1_block_143NumDims, false);
            x_models_1_block_149 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_1_block_149, [3 4 2 1], 4);

            x_models_1_block_149 = dlarray(single(x_models_1_block_149), 'SSCB');
        end

        function [x_models_1_block_149] = forward(this, x_models_1_block_143)
            if isdlarray(x_models_1_block_143)
                x_models_1_block_143 = stripdims(x_models_1_block_143);
            end
            x_models_1_block_143NumDims = 4;
            x_models_1_block_143 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_1_block_143, [4 3 1 2], 4);

            [x_models_1_block_149, x_models_1_block_149NumDims] = ReduceMeanGraph1099(this, x_models_1_block_143, x_models_1_block_143NumDims, true);
            x_models_1_block_149 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_1_block_149, [3 4 2 1], 4);

            x_models_1_block_149 = dlarray(single(x_models_1_block_149), 'SSCB');
        end

        function [x_models_1_block_149, x_models_1_block_149NumDims1101] = ReduceMeanGraph1099(this, x_models_1_block_143, x_models_1_block_143NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1100, x_models_1_block_143NumDims);
            xMean = mean(x_models_1_block_143, dims);
            x_models_1_block_149 = xMean;
            x_models_1_block_149NumDims = x_models_1_block_143NumDims;

            % Set graph output arguments
            x_models_1_block_149NumDims1101 = x_models_1_block_149NumDims;

        end

    end

end