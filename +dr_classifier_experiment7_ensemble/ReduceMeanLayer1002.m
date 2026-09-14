classdef ReduceMeanLayer1002 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1002';
        end
    end


    methods
        function this = ReduceMeanLayer1002(name)
            this.Name = name;
            this.OutputNames = {'x_models_2_blocks_31'};
        end

        function [x_models_2_blocks_31] = predict(this, x_models_2_blocks_25)
            if isdlarray(x_models_2_blocks_25)
                x_models_2_blocks_25 = stripdims(x_models_2_blocks_25);
            end
            x_models_2_blocks_25NumDims = 4;
            x_models_2_blocks_25 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_2_blocks_25, [4 3 1 2], 4);

            [x_models_2_blocks_31, x_models_2_blocks_31NumDims] = ReduceMeanGraph1006(this, x_models_2_blocks_25, x_models_2_blocks_25NumDims, false);
            x_models_2_blocks_31 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_2_blocks_31, [3 4 2 1], 4);

            x_models_2_blocks_31 = dlarray(single(x_models_2_blocks_31), 'SSCB');
        end

        function [x_models_2_blocks_31] = forward(this, x_models_2_blocks_25)
            if isdlarray(x_models_2_blocks_25)
                x_models_2_blocks_25 = stripdims(x_models_2_blocks_25);
            end
            x_models_2_blocks_25NumDims = 4;
            x_models_2_blocks_25 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_2_blocks_25, [4 3 1 2], 4);

            [x_models_2_blocks_31, x_models_2_blocks_31NumDims] = ReduceMeanGraph1006(this, x_models_2_blocks_25, x_models_2_blocks_25NumDims, true);
            x_models_2_blocks_31 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_2_blocks_31, [3 4 2 1], 4);

            x_models_2_blocks_31 = dlarray(single(x_models_2_blocks_31), 'SSCB');
        end

        function [x_models_2_blocks_31, x_models_2_blocks_31NumDims1008] = ReduceMeanGraph1006(this, x_models_2_blocks_25, x_models_2_blocks_25NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1007, x_models_2_blocks_25NumDims);
            xMean = mean(x_models_2_blocks_25, dims);
            x_models_2_blocks_31 = xMean;
            x_models_2_blocks_31NumDims = x_models_2_blocks_25NumDims;

            % Set graph output arguments
            x_models_2_blocks_31NumDims1008 = x_models_2_blocks_31NumDims;

        end

    end

end