classdef ReduceMeanLayer1047 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1047';
        end
    end


    methods
        function this = ReduceMeanLayer1047(name)
            this.Name = name;
            this.OutputNames = {'x_models_0_blocks_17'};
        end

        function [x_models_0_blocks_17] = predict(this, x_models_0_blocks_12)
            if isdlarray(x_models_0_blocks_12)
                x_models_0_blocks_12 = stripdims(x_models_0_blocks_12);
            end
            x_models_0_blocks_12NumDims = 4;
            x_models_0_blocks_12 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_0_blocks_12, [4 3 1 2], 4);

            [x_models_0_blocks_17, x_models_0_blocks_17NumDims] = ReduceMeanGraph1141(this, x_models_0_blocks_12, x_models_0_blocks_12NumDims, false);
            x_models_0_blocks_17 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_0_blocks_17, [3 4 2 1], 4);

            x_models_0_blocks_17 = dlarray(single(x_models_0_blocks_17), 'SSCB');
        end

        function [x_models_0_blocks_17] = forward(this, x_models_0_blocks_12)
            if isdlarray(x_models_0_blocks_12)
                x_models_0_blocks_12 = stripdims(x_models_0_blocks_12);
            end
            x_models_0_blocks_12NumDims = 4;
            x_models_0_blocks_12 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_0_blocks_12, [4 3 1 2], 4);

            [x_models_0_blocks_17, x_models_0_blocks_17NumDims] = ReduceMeanGraph1141(this, x_models_0_blocks_12, x_models_0_blocks_12NumDims, true);
            x_models_0_blocks_17 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_0_blocks_17, [3 4 2 1], 4);

            x_models_0_blocks_17 = dlarray(single(x_models_0_blocks_17), 'SSCB');
        end

        function [x_models_0_blocks_17, x_models_0_blocks_17NumDims1143] = ReduceMeanGraph1141(this, x_models_0_blocks_12, x_models_0_blocks_12NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1142, x_models_0_blocks_12NumDims);
            xMean = mean(x_models_0_blocks_12, dims);
            x_models_0_blocks_17 = xMean;
            x_models_0_blocks_17NumDims = x_models_0_blocks_12NumDims;

            % Set graph output arguments
            x_models_0_blocks_17NumDims1143 = x_models_0_blocks_17NumDims;

        end

    end

end