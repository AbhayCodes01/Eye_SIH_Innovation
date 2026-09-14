classdef ReduceMeanLayer1006 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1006';
        end
    end


    methods
        function this = ReduceMeanLayer1006(name)
            this.Name = name;
            this.OutputNames = {'x_models_2_blocks_90'};
        end

        function [x_models_2_blocks_90] = predict(this, x_models_2_blocks_84)
            if isdlarray(x_models_2_blocks_84)
                x_models_2_blocks_84 = stripdims(x_models_2_blocks_84);
            end
            x_models_2_blocks_84NumDims = 4;
            x_models_2_blocks_84 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_2_blocks_84, [4 3 1 2], 4);

            [x_models_2_blocks_90, x_models_2_blocks_90NumDims] = ReduceMeanGraph1018(this, x_models_2_blocks_84, x_models_2_blocks_84NumDims, false);
            x_models_2_blocks_90 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_2_blocks_90, [3 4 2 1], 4);

            x_models_2_blocks_90 = dlarray(single(x_models_2_blocks_90), 'SSCB');
        end

        function [x_models_2_blocks_90] = forward(this, x_models_2_blocks_84)
            if isdlarray(x_models_2_blocks_84)
                x_models_2_blocks_84 = stripdims(x_models_2_blocks_84);
            end
            x_models_2_blocks_84NumDims = 4;
            x_models_2_blocks_84 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_2_blocks_84, [4 3 1 2], 4);

            [x_models_2_blocks_90, x_models_2_blocks_90NumDims] = ReduceMeanGraph1018(this, x_models_2_blocks_84, x_models_2_blocks_84NumDims, true);
            x_models_2_blocks_90 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_2_blocks_90, [3 4 2 1], 4);

            x_models_2_blocks_90 = dlarray(single(x_models_2_blocks_90), 'SSCB');
        end

        function [x_models_2_blocks_90, x_models_2_blocks_90NumDims1020] = ReduceMeanGraph1018(this, x_models_2_blocks_84, x_models_2_blocks_84NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1019, x_models_2_blocks_84NumDims);
            xMean = mean(x_models_2_blocks_84, dims);
            x_models_2_blocks_90 = xMean;
            x_models_2_blocks_90NumDims = x_models_2_blocks_84NumDims;

            % Set graph output arguments
            x_models_2_blocks_90NumDims1020 = x_models_2_blocks_90NumDims;

        end

    end

end