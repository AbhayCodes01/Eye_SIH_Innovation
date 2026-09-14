classdef ReduceMeanLayer1025 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1025';
        end
    end


    methods
        function this = ReduceMeanLayer1025(name)
            this.Name = name;
            this.OutputNames = {'x_models_1_blocks_31'};
        end

        function [x_models_1_blocks_31] = predict(this, x_models_1_blocks_25)
            if isdlarray(x_models_1_blocks_25)
                x_models_1_blocks_25 = stripdims(x_models_1_blocks_25);
            end
            x_models_1_blocks_25NumDims = 4;
            x_models_1_blocks_25 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_1_blocks_25, [4 3 1 2], 4);

            [x_models_1_blocks_31, x_models_1_blocks_31NumDims] = ReduceMeanGraph1075(this, x_models_1_blocks_25, x_models_1_blocks_25NumDims, false);
            x_models_1_blocks_31 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_1_blocks_31, [3 4 2 1], 4);

            x_models_1_blocks_31 = dlarray(single(x_models_1_blocks_31), 'SSCB');
        end

        function [x_models_1_blocks_31] = forward(this, x_models_1_blocks_25)
            if isdlarray(x_models_1_blocks_25)
                x_models_1_blocks_25 = stripdims(x_models_1_blocks_25);
            end
            x_models_1_blocks_25NumDims = 4;
            x_models_1_blocks_25 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_1_blocks_25, [4 3 1 2], 4);

            [x_models_1_blocks_31, x_models_1_blocks_31NumDims] = ReduceMeanGraph1075(this, x_models_1_blocks_25, x_models_1_blocks_25NumDims, true);
            x_models_1_blocks_31 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_1_blocks_31, [3 4 2 1], 4);

            x_models_1_blocks_31 = dlarray(single(x_models_1_blocks_31), 'SSCB');
        end

        function [x_models_1_blocks_31, x_models_1_blocks_31NumDims1077] = ReduceMeanGraph1075(this, x_models_1_blocks_25, x_models_1_blocks_25NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1076, x_models_1_blocks_25NumDims);
            xMean = mean(x_models_1_blocks_25, dims);
            x_models_1_blocks_31 = xMean;
            x_models_1_blocks_31NumDims = x_models_1_blocks_25NumDims;

            % Set graph output arguments
            x_models_1_blocks_31NumDims1077 = x_models_1_blocks_31NumDims;

        end

    end

end