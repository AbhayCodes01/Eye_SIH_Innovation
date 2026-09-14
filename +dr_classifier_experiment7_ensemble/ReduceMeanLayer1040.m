classdef ReduceMeanLayer1040 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1040';
        end
    end


    methods
        function this = ReduceMeanLayer1040(name)
            this.Name = name;
            this.OutputNames = {'x_models_1_block_252'};
        end

        function [x_models_1_block_252] = predict(this, x_models_1_block_246)
            if isdlarray(x_models_1_block_246)
                x_models_1_block_246 = stripdims(x_models_1_block_246);
            end
            x_models_1_block_246NumDims = 4;
            x_models_1_block_246 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_1_block_246, [4 3 1 2], 4);

            [x_models_1_block_252, x_models_1_block_252NumDims] = ReduceMeanGraph1120(this, x_models_1_block_246, x_models_1_block_246NumDims, false);
            x_models_1_block_252 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_1_block_252, [3 4 2 1], 4);

            x_models_1_block_252 = dlarray(single(x_models_1_block_252), 'SSCB');
        end

        function [x_models_1_block_252] = forward(this, x_models_1_block_246)
            if isdlarray(x_models_1_block_246)
                x_models_1_block_246 = stripdims(x_models_1_block_246);
            end
            x_models_1_block_246NumDims = 4;
            x_models_1_block_246 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_1_block_246, [4 3 1 2], 4);

            [x_models_1_block_252, x_models_1_block_252NumDims] = ReduceMeanGraph1120(this, x_models_1_block_246, x_models_1_block_246NumDims, true);
            x_models_1_block_252 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_1_block_252, [3 4 2 1], 4);

            x_models_1_block_252 = dlarray(single(x_models_1_block_252), 'SSCB');
        end

        function [x_models_1_block_252, x_models_1_block_252NumDims1122] = ReduceMeanGraph1120(this, x_models_1_block_246, x_models_1_block_246NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1121, x_models_1_block_246NumDims);
            xMean = mean(x_models_1_block_246, dims);
            x_models_1_block_252 = xMean;
            x_models_1_block_252NumDims = x_models_1_block_246NumDims;

            % Set graph output arguments
            x_models_1_block_252NumDims1122 = x_models_1_block_252NumDims;

        end

    end

end