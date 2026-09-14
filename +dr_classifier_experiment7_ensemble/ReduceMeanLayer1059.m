classdef ReduceMeanLayer1059 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1059';
        end
    end


    methods
        function this = ReduceMeanLayer1059(name)
            this.Name = name;
            this.OutputNames = {'x_models_0_block_193'};
        end

        function [x_models_0_block_193] = predict(this, x_models_0_block_187)
            if isdlarray(x_models_0_block_187)
                x_models_0_block_187 = stripdims(x_models_0_block_187);
            end
            x_models_0_block_187NumDims = 4;
            x_models_0_block_187 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_0_block_187, [4 3 1 2], 4);

            [x_models_0_block_193, x_models_0_block_193NumDims] = ReduceMeanGraph1177(this, x_models_0_block_187, x_models_0_block_187NumDims, false);
            x_models_0_block_193 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_0_block_193, [3 4 2 1], 4);

            x_models_0_block_193 = dlarray(single(x_models_0_block_193), 'SSCB');
        end

        function [x_models_0_block_193] = forward(this, x_models_0_block_187)
            if isdlarray(x_models_0_block_187)
                x_models_0_block_187 = stripdims(x_models_0_block_187);
            end
            x_models_0_block_187NumDims = 4;
            x_models_0_block_187 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_0_block_187, [4 3 1 2], 4);

            [x_models_0_block_193, x_models_0_block_193NumDims] = ReduceMeanGraph1177(this, x_models_0_block_187, x_models_0_block_187NumDims, true);
            x_models_0_block_193 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_0_block_193, [3 4 2 1], 4);

            x_models_0_block_193 = dlarray(single(x_models_0_block_193), 'SSCB');
        end

        function [x_models_0_block_193, x_models_0_block_193NumDims1179] = ReduceMeanGraph1177(this, x_models_0_block_187, x_models_0_block_187NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1178, x_models_0_block_187NumDims);
            xMean = mean(x_models_0_block_187, dims);
            x_models_0_block_193 = xMean;
            x_models_0_block_193NumDims = x_models_0_block_187NumDims;

            % Set graph output arguments
            x_models_0_block_193NumDims1179 = x_models_0_block_193NumDims;

        end

    end

end