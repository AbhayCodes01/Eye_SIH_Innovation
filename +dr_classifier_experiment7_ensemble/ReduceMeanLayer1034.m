classdef ReduceMeanLayer1034 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1034';
        end
    end


    methods
        function this = ReduceMeanLayer1034(name)
            this.Name = name;
            this.OutputNames = {'x_models_1_block_164'};
        end

        function [x_models_1_block_164] = predict(this, x_models_1_block_158)
            if isdlarray(x_models_1_block_158)
                x_models_1_block_158 = stripdims(x_models_1_block_158);
            end
            x_models_1_block_158NumDims = 4;
            x_models_1_block_158 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_1_block_158, [4 3 1 2], 4);

            [x_models_1_block_164, x_models_1_block_164NumDims] = ReduceMeanGraph1102(this, x_models_1_block_158, x_models_1_block_158NumDims, false);
            x_models_1_block_164 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_1_block_164, [3 4 2 1], 4);

            x_models_1_block_164 = dlarray(single(x_models_1_block_164), 'SSCB');
        end

        function [x_models_1_block_164] = forward(this, x_models_1_block_158)
            if isdlarray(x_models_1_block_158)
                x_models_1_block_158 = stripdims(x_models_1_block_158);
            end
            x_models_1_block_158NumDims = 4;
            x_models_1_block_158 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_1_block_158, [4 3 1 2], 4);

            [x_models_1_block_164, x_models_1_block_164NumDims] = ReduceMeanGraph1102(this, x_models_1_block_158, x_models_1_block_158NumDims, true);
            x_models_1_block_164 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_1_block_164, [3 4 2 1], 4);

            x_models_1_block_164 = dlarray(single(x_models_1_block_164), 'SSCB');
        end

        function [x_models_1_block_164, x_models_1_block_164NumDims1104] = ReduceMeanGraph1102(this, x_models_1_block_158, x_models_1_block_158NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1103, x_models_1_block_158NumDims);
            xMean = mean(x_models_1_block_158, dims);
            x_models_1_block_164 = xMean;
            x_models_1_block_164NumDims = x_models_1_block_158NumDims;

            % Set graph output arguments
            x_models_1_block_164NumDims1104 = x_models_1_block_164NumDims;

        end

    end

end