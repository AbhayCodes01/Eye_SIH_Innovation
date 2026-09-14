classdef ReduceMeanLayer1009 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1009';
        end
    end


    methods
        function this = ReduceMeanLayer1009(name)
            this.Name = name;
            this.OutputNames = {'x_models_2_block_134'};
        end

        function [x_models_2_block_134] = predict(this, x_models_2_block_128)
            if isdlarray(x_models_2_block_128)
                x_models_2_block_128 = stripdims(x_models_2_block_128);
            end
            x_models_2_block_128NumDims = 4;
            x_models_2_block_128 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_2_block_128, [4 3 1 2], 4);

            [x_models_2_block_134, x_models_2_block_134NumDims] = ReduceMeanGraph1027(this, x_models_2_block_128, x_models_2_block_128NumDims, false);
            x_models_2_block_134 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_2_block_134, [3 4 2 1], 4);

            x_models_2_block_134 = dlarray(single(x_models_2_block_134), 'SSCB');
        end

        function [x_models_2_block_134] = forward(this, x_models_2_block_128)
            if isdlarray(x_models_2_block_128)
                x_models_2_block_128 = stripdims(x_models_2_block_128);
            end
            x_models_2_block_128NumDims = 4;
            x_models_2_block_128 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_2_block_128, [4 3 1 2], 4);

            [x_models_2_block_134, x_models_2_block_134NumDims] = ReduceMeanGraph1027(this, x_models_2_block_128, x_models_2_block_128NumDims, true);
            x_models_2_block_134 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_2_block_134, [3 4 2 1], 4);

            x_models_2_block_134 = dlarray(single(x_models_2_block_134), 'SSCB');
        end

        function [x_models_2_block_134, x_models_2_block_134NumDims1029] = ReduceMeanGraph1027(this, x_models_2_block_128, x_models_2_block_128NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1028, x_models_2_block_128NumDims);
            xMean = mean(x_models_2_block_128, dims);
            x_models_2_block_134 = xMean;
            x_models_2_block_134NumDims = x_models_2_block_128NumDims;

            % Set graph output arguments
            x_models_2_block_134NumDims1029 = x_models_2_block_134NumDims;

        end

    end

end