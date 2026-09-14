classdef ReduceMeanLayer1012 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1012';
        end
    end


    methods
        function this = ReduceMeanLayer1012(name)
            this.Name = name;
            this.OutputNames = {'x_models_2_block_178'};
        end

        function [x_models_2_block_178] = predict(this, x_models_2_block_172)
            if isdlarray(x_models_2_block_172)
                x_models_2_block_172 = stripdims(x_models_2_block_172);
            end
            x_models_2_block_172NumDims = 4;
            x_models_2_block_172 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_2_block_172, [4 3 1 2], 4);

            [x_models_2_block_178, x_models_2_block_178NumDims] = ReduceMeanGraph1036(this, x_models_2_block_172, x_models_2_block_172NumDims, false);
            x_models_2_block_178 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_2_block_178, [3 4 2 1], 4);

            x_models_2_block_178 = dlarray(single(x_models_2_block_178), 'SSCB');
        end

        function [x_models_2_block_178] = forward(this, x_models_2_block_172)
            if isdlarray(x_models_2_block_172)
                x_models_2_block_172 = stripdims(x_models_2_block_172);
            end
            x_models_2_block_172NumDims = 4;
            x_models_2_block_172 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_2_block_172, [4 3 1 2], 4);

            [x_models_2_block_178, x_models_2_block_178NumDims] = ReduceMeanGraph1036(this, x_models_2_block_172, x_models_2_block_172NumDims, true);
            x_models_2_block_178 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_2_block_178, [3 4 2 1], 4);

            x_models_2_block_178 = dlarray(single(x_models_2_block_178), 'SSCB');
        end

        function [x_models_2_block_178, x_models_2_block_178NumDims1038] = ReduceMeanGraph1036(this, x_models_2_block_172, x_models_2_block_172NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1037, x_models_2_block_172NumDims);
            xMean = mean(x_models_2_block_172, dims);
            x_models_2_block_178 = xMean;
            x_models_2_block_178NumDims = x_models_2_block_172NumDims;

            % Set graph output arguments
            x_models_2_block_178NumDims1038 = x_models_2_block_178NumDims;

        end

    end

end