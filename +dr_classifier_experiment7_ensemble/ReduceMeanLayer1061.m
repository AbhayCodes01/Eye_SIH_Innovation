classdef ReduceMeanLayer1061 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1061';
        end
    end


    methods
        function this = ReduceMeanLayer1061(name)
            this.Name = name;
            this.OutputNames = {'x_models_0_block_223'};
        end

        function [x_models_0_block_223] = predict(this, x_models_0_block_217)
            if isdlarray(x_models_0_block_217)
                x_models_0_block_217 = stripdims(x_models_0_block_217);
            end
            x_models_0_block_217NumDims = 4;
            x_models_0_block_217 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_0_block_217, [4 3 1 2], 4);

            [x_models_0_block_223, x_models_0_block_223NumDims] = ReduceMeanGraph1183(this, x_models_0_block_217, x_models_0_block_217NumDims, false);
            x_models_0_block_223 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_0_block_223, [3 4 2 1], 4);

            x_models_0_block_223 = dlarray(single(x_models_0_block_223), 'SSCB');
        end

        function [x_models_0_block_223] = forward(this, x_models_0_block_217)
            if isdlarray(x_models_0_block_217)
                x_models_0_block_217 = stripdims(x_models_0_block_217);
            end
            x_models_0_block_217NumDims = 4;
            x_models_0_block_217 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_0_block_217, [4 3 1 2], 4);

            [x_models_0_block_223, x_models_0_block_223NumDims] = ReduceMeanGraph1183(this, x_models_0_block_217, x_models_0_block_217NumDims, true);
            x_models_0_block_223 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_0_block_223, [3 4 2 1], 4);

            x_models_0_block_223 = dlarray(single(x_models_0_block_223), 'SSCB');
        end

        function [x_models_0_block_223, x_models_0_block_223NumDims1185] = ReduceMeanGraph1183(this, x_models_0_block_217, x_models_0_block_217NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1184, x_models_0_block_217NumDims);
            xMean = mean(x_models_0_block_217, dims);
            x_models_0_block_223 = xMean;
            x_models_0_block_223NumDims = x_models_0_block_217NumDims;

            % Set graph output arguments
            x_models_0_block_223NumDims1185 = x_models_0_block_223NumDims;

        end

    end

end