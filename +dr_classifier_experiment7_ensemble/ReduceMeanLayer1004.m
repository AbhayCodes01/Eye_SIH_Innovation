classdef ReduceMeanLayer1004 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1004';
        end
    end


    methods
        function this = ReduceMeanLayer1004(name)
            this.Name = name;
            this.OutputNames = {'x_models_2_blocks_61'};
        end

        function [x_models_2_blocks_61] = predict(this, x_models_2_blocks_55)
            if isdlarray(x_models_2_blocks_55)
                x_models_2_blocks_55 = stripdims(x_models_2_blocks_55);
            end
            x_models_2_blocks_55NumDims = 4;
            x_models_2_blocks_55 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_2_blocks_55, [4 3 1 2], 4);

            [x_models_2_blocks_61, x_models_2_blocks_61NumDims] = ReduceMeanGraph1012(this, x_models_2_blocks_55, x_models_2_blocks_55NumDims, false);
            x_models_2_blocks_61 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_2_blocks_61, [3 4 2 1], 4);

            x_models_2_blocks_61 = dlarray(single(x_models_2_blocks_61), 'SSCB');
        end

        function [x_models_2_blocks_61] = forward(this, x_models_2_blocks_55)
            if isdlarray(x_models_2_blocks_55)
                x_models_2_blocks_55 = stripdims(x_models_2_blocks_55);
            end
            x_models_2_blocks_55NumDims = 4;
            x_models_2_blocks_55 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_2_blocks_55, [4 3 1 2], 4);

            [x_models_2_blocks_61, x_models_2_blocks_61NumDims] = ReduceMeanGraph1012(this, x_models_2_blocks_55, x_models_2_blocks_55NumDims, true);
            x_models_2_blocks_61 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_2_blocks_61, [3 4 2 1], 4);

            x_models_2_blocks_61 = dlarray(single(x_models_2_blocks_61), 'SSCB');
        end

        function [x_models_2_blocks_61, x_models_2_blocks_61NumDims1014] = ReduceMeanGraph1012(this, x_models_2_blocks_55, x_models_2_blocks_55NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1013, x_models_2_blocks_55NumDims);
            xMean = mean(x_models_2_blocks_55, dims);
            x_models_2_blocks_61 = xMean;
            x_models_2_blocks_61NumDims = x_models_2_blocks_55NumDims;

            % Set graph output arguments
            x_models_2_blocks_61NumDims1014 = x_models_2_blocks_61NumDims;

        end

    end

end