classdef ReduceMeanLayer1044 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1044';
        end
    end


    methods
        function this = ReduceMeanLayer1044(name)
            this.Name = name;
            this.OutputNames = {'x_models_1_block_311'};
        end

        function [x_models_1_block_311] = predict(this, x_models_1_block_305)
            if isdlarray(x_models_1_block_305)
                x_models_1_block_305 = stripdims(x_models_1_block_305);
            end
            x_models_1_block_305NumDims = 4;
            x_models_1_block_305 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_1_block_305, [4 3 1 2], 4);

            [x_models_1_block_311, x_models_1_block_311NumDims] = ReduceMeanGraph1132(this, x_models_1_block_305, x_models_1_block_305NumDims, false);
            x_models_1_block_311 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_1_block_311, [3 4 2 1], 4);

            x_models_1_block_311 = dlarray(single(x_models_1_block_311), 'SSCB');
        end

        function [x_models_1_block_311] = forward(this, x_models_1_block_305)
            if isdlarray(x_models_1_block_305)
                x_models_1_block_305 = stripdims(x_models_1_block_305);
            end
            x_models_1_block_305NumDims = 4;
            x_models_1_block_305 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_1_block_305, [4 3 1 2], 4);

            [x_models_1_block_311, x_models_1_block_311NumDims] = ReduceMeanGraph1132(this, x_models_1_block_305, x_models_1_block_305NumDims, true);
            x_models_1_block_311 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_1_block_311, [3 4 2 1], 4);

            x_models_1_block_311 = dlarray(single(x_models_1_block_311), 'SSCB');
        end

        function [x_models_1_block_311, x_models_1_block_311NumDims1134] = ReduceMeanGraph1132(this, x_models_1_block_305, x_models_1_block_305NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1133, x_models_1_block_305NumDims);
            xMean = mean(x_models_1_block_305, dims);
            x_models_1_block_311 = xMean;
            x_models_1_block_311NumDims = x_models_1_block_305NumDims;

            % Set graph output arguments
            x_models_1_block_311NumDims1134 = x_models_1_block_311NumDims;

        end

    end

end