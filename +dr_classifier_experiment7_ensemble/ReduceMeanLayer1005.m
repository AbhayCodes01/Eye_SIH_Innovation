classdef ReduceMeanLayer1005 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1005';
        end
    end


    methods
        function this = ReduceMeanLayer1005(name)
            this.Name = name;
            this.OutputNames = {'x_models_2_blocks_75'};
        end

        function [x_models_2_blocks_75] = predict(this, x_models_2_blocks_69)
            if isdlarray(x_models_2_blocks_69)
                x_models_2_blocks_69 = stripdims(x_models_2_blocks_69);
            end
            x_models_2_blocks_69NumDims = 4;
            x_models_2_blocks_69 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_2_blocks_69, [4 3 1 2], 4);

            [x_models_2_blocks_75, x_models_2_blocks_75NumDims] = ReduceMeanGraph1015(this, x_models_2_blocks_69, x_models_2_blocks_69NumDims, false);
            x_models_2_blocks_75 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_2_blocks_75, [3 4 2 1], 4);

            x_models_2_blocks_75 = dlarray(single(x_models_2_blocks_75), 'SSCB');
        end

        function [x_models_2_blocks_75] = forward(this, x_models_2_blocks_69)
            if isdlarray(x_models_2_blocks_69)
                x_models_2_blocks_69 = stripdims(x_models_2_blocks_69);
            end
            x_models_2_blocks_69NumDims = 4;
            x_models_2_blocks_69 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_2_blocks_69, [4 3 1 2], 4);

            [x_models_2_blocks_75, x_models_2_blocks_75NumDims] = ReduceMeanGraph1015(this, x_models_2_blocks_69, x_models_2_blocks_69NumDims, true);
            x_models_2_blocks_75 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_2_blocks_75, [3 4 2 1], 4);

            x_models_2_blocks_75 = dlarray(single(x_models_2_blocks_75), 'SSCB');
        end

        function [x_models_2_blocks_75, x_models_2_blocks_75NumDims1017] = ReduceMeanGraph1015(this, x_models_2_blocks_69, x_models_2_blocks_69NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1016, x_models_2_blocks_69NumDims);
            xMean = mean(x_models_2_blocks_69, dims);
            x_models_2_blocks_75 = xMean;
            x_models_2_blocks_75NumDims = x_models_2_blocks_69NumDims;

            % Set graph output arguments
            x_models_2_blocks_75NumDims1017 = x_models_2_blocks_75NumDims;

        end

    end

end