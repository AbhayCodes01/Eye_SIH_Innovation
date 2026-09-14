classdef ReduceMeanLayer1066 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1066';
        end
    end


    methods
        function this = ReduceMeanLayer1066(name)
            this.Name = name;
            this.OutputNames = {'x_models_0_block_297'};
        end

        function [x_models_0_block_297] = predict(this, x_models_0_block_291)
            if isdlarray(x_models_0_block_291)
                x_models_0_block_291 = stripdims(x_models_0_block_291);
            end
            x_models_0_block_291NumDims = 4;
            x_models_0_block_291 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_0_block_291, [4 3 1 2], 4);

            [x_models_0_block_297, x_models_0_block_297NumDims] = ReduceMeanGraph1198(this, x_models_0_block_291, x_models_0_block_291NumDims, false);
            x_models_0_block_297 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_0_block_297, [3 4 2 1], 4);

            x_models_0_block_297 = dlarray(single(x_models_0_block_297), 'SSCB');
        end

        function [x_models_0_block_297] = forward(this, x_models_0_block_291)
            if isdlarray(x_models_0_block_291)
                x_models_0_block_291 = stripdims(x_models_0_block_291);
            end
            x_models_0_block_291NumDims = 4;
            x_models_0_block_291 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_0_block_291, [4 3 1 2], 4);

            [x_models_0_block_297, x_models_0_block_297NumDims] = ReduceMeanGraph1198(this, x_models_0_block_291, x_models_0_block_291NumDims, true);
            x_models_0_block_297 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_0_block_297, [3 4 2 1], 4);

            x_models_0_block_297 = dlarray(single(x_models_0_block_297), 'SSCB');
        end

        function [x_models_0_block_297, x_models_0_block_297NumDims1200] = ReduceMeanGraph1198(this, x_models_0_block_291, x_models_0_block_291NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1199, x_models_0_block_291NumDims);
            xMean = mean(x_models_0_block_291, dims);
            x_models_0_block_297 = xMean;
            x_models_0_block_297NumDims = x_models_0_block_291NumDims;

            % Set graph output arguments
            x_models_0_block_297NumDims1200 = x_models_0_block_297NumDims;

        end

    end

end