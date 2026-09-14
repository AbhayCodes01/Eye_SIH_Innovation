classdef ReduceMeanLayer1031 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1031';
        end
    end


    methods
        function this = ReduceMeanLayer1031(name)
            this.Name = name;
            this.OutputNames = {'x_models_1_block_119'};
        end

        function [x_models_1_block_119] = predict(this, x_models_1_block_113)
            if isdlarray(x_models_1_block_113)
                x_models_1_block_113 = stripdims(x_models_1_block_113);
            end
            x_models_1_block_113NumDims = 4;
            x_models_1_block_113 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_1_block_113, [4 3 1 2], 4);

            [x_models_1_block_119, x_models_1_block_119NumDims] = ReduceMeanGraph1093(this, x_models_1_block_113, x_models_1_block_113NumDims, false);
            x_models_1_block_119 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_1_block_119, [3 4 2 1], 4);

            x_models_1_block_119 = dlarray(single(x_models_1_block_119), 'SSCB');
        end

        function [x_models_1_block_119] = forward(this, x_models_1_block_113)
            if isdlarray(x_models_1_block_113)
                x_models_1_block_113 = stripdims(x_models_1_block_113);
            end
            x_models_1_block_113NumDims = 4;
            x_models_1_block_113 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_1_block_113, [4 3 1 2], 4);

            [x_models_1_block_119, x_models_1_block_119NumDims] = ReduceMeanGraph1093(this, x_models_1_block_113, x_models_1_block_113NumDims, true);
            x_models_1_block_119 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_1_block_119, [3 4 2 1], 4);

            x_models_1_block_119 = dlarray(single(x_models_1_block_119), 'SSCB');
        end

        function [x_models_1_block_119, x_models_1_block_119NumDims1095] = ReduceMeanGraph1093(this, x_models_1_block_113, x_models_1_block_113NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1094, x_models_1_block_113NumDims);
            xMean = mean(x_models_1_block_113, dims);
            x_models_1_block_119 = xMean;
            x_models_1_block_119NumDims = x_models_1_block_113NumDims;

            % Set graph output arguments
            x_models_1_block_119NumDims1095 = x_models_1_block_119NumDims;

        end

    end

end