classdef ReduceMeanLayer1060 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_experiment7_ensemble.coder.ReduceMeanLayer1060';
        end
    end


    methods
        function this = ReduceMeanLayer1060(name)
            this.Name = name;
            this.OutputNames = {'x_models_0_block_208'};
        end

        function [x_models_0_block_208] = predict(this, x_models_0_block_202)
            if isdlarray(x_models_0_block_202)
                x_models_0_block_202 = stripdims(x_models_0_block_202);
            end
            x_models_0_block_202NumDims = 4;
            x_models_0_block_202 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_0_block_202, [4 3 1 2], 4);

            [x_models_0_block_208, x_models_0_block_208NumDims] = ReduceMeanGraph1180(this, x_models_0_block_202, x_models_0_block_202NumDims, false);
            x_models_0_block_208 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_0_block_208, [3 4 2 1], 4);

            x_models_0_block_208 = dlarray(single(x_models_0_block_208), 'SSCB');
        end

        function [x_models_0_block_208] = forward(this, x_models_0_block_202)
            if isdlarray(x_models_0_block_202)
                x_models_0_block_202 = stripdims(x_models_0_block_202);
            end
            x_models_0_block_202NumDims = 4;
            x_models_0_block_202 = dr_classifier_experiment7_ensemble.ops.permuteInputVar(x_models_0_block_202, [4 3 1 2], 4);

            [x_models_0_block_208, x_models_0_block_208NumDims] = ReduceMeanGraph1180(this, x_models_0_block_202, x_models_0_block_202NumDims, true);
            x_models_0_block_208 = dr_classifier_experiment7_ensemble.ops.permuteOutputVar(x_models_0_block_208, [3 4 2 1], 4);

            x_models_0_block_208 = dlarray(single(x_models_0_block_208), 'SSCB');
        end

        function [x_models_0_block_208, x_models_0_block_208NumDims1182] = ReduceMeanGraph1180(this, x_models_0_block_202, x_models_0_block_202NumDims, Training)

            % Execute the operators:
            % ReduceMean:
            dims = dr_classifier_experiment7_ensemble.ops.prepareReduceArgs(this.Vars.ReduceMeanAxes1181, x_models_0_block_202NumDims);
            xMean = mean(x_models_0_block_202, dims);
            x_models_0_block_208 = xMean;
            x_models_0_block_208NumDims = x_models_0_block_202NumDims;

            % Set graph output arguments
            x_models_0_block_208NumDims1182 = x_models_0_block_208NumDims;

        end

    end

end