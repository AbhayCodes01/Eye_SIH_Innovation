classdef ReduceMeanLayer1003 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1003';
        end
    end


    methods
        function this = ReduceMeanLayer1003(name)
            this.Name = name;
            this.OutputNames = {'x_models_2_blocks_46'};
        end

        function [x_models_2_blocks_46] = predict(this, x_models_2_blocks_40)
            if isdlarray(x_models_2_blocks_40)
                x_models_2_blocks_40 = stripdims(x_models_2_blocks_40);
            end
            x_models_2_blocks_40NumDims = 4;
            x_models_2_blocks_40 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_2_blocks_40, [4 3 1 2], 4);

            [x_models_2_blocks_46, x_models_2_blocks_46NumDims] = ReduceMeanGraph1009(this, x_models_2_blocks_40, x_models_2_blocks_40NumDims, false);
            x_models_2_blocks_46 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_2_blocks_46, [3 4 2 1], 4);

            x_models_2_blocks_46 = dlarray(single(x_models_2_blocks_46), 'SSCB');
        end

        function [x_models_2_blocks_46] = forward(this, x_models_2_blocks_40)
            if isdlarray(x_models_2_blocks_40)
                x_models_2_blocks_40 = stripdims(x_models_2_blocks_40);
            end
            x_models_2_blocks_40NumDims = 4;
            x_models_2_blocks_40 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_2_blocks_40, [4 3 1 2], 4);

            [x_models_2_blocks_46, x_models_2_blocks_46NumDims] = ReduceMeanGraph1009(this, x_models_2_blocks_40, x_models_2_blocks_40NumDims, true);
            x_models_2_blocks_46 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_2_blocks_46, [3 4 2 1], 4);

            x_models_2_blocks_46 = dlarray(single(x_models_2_blocks_46), 'SSCB');
        end

        function [x_models_2_blocks_46, x_models_2_blocks_46NumDims1011] = ReduceMeanGraph1009(this, x_models_2_blocks_40, x_models_2_blocks_40NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1010, x_models_2_blocks_40NumDims);
            xMean = mean(x_models_2_blocks_40, dims);
            x_models_2_blocks_46 = xMean;
            x_models_2_blocks_46NumDims = x_models_2_blocks_40NumDims;

            % Set graph output arguments
            x_models_2_blocks_46NumDims1011 = x_models_2_blocks_46NumDims;

        end

    end

end