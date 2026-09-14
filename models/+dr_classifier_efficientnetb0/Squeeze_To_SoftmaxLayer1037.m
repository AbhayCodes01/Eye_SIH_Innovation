classdef Squeeze_To_SoftmaxLayer1037 < nnet.layer.Layer & nnet.layer.Formattable
    % A custom layer auto-generated while importing an ONNX network.

    %#ok<*PROPLC>
    %#ok<*NBRAK>
    %#ok<*INUSL>
    %#ok<*VARARG>
    properties (Learnable)
        sequential_1_dense_3
        sequential_1_dense_8
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
            name = 'dr_classifier_efficientnetb0.coder.Squeeze_To_SoftmaxLayer1037';
        end
    end


    methods
        function this = Squeeze_To_SoftmaxLayer1037(name)
            this.Name = name;
            this.OutputNames = {'output'};
        end

        function [output] = predict(this, sequential_1_global_)
            if isdlarray(sequential_1_global_)
                sequential_1_global_ = stripdims(sequential_1_global_);
            end
            sequential_1_global_NumDims = 4;
            sequential_1_global_ = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_global_, [4 3 1 2], 4);

            [output, outputNumDims] = Squeeze_To_SoftmaxGraph1074(this, sequential_1_global_, sequential_1_global_NumDims, false);
            output = dr_classifier_efficientnetb0.ops.permuteOutputVar(output, ['as-is'], 2);

            output = dlarray(single(output), repmat('U', 1, max(2, outputNumDims)));
        end

        function [output] = forward(this, sequential_1_global_)
            if isdlarray(sequential_1_global_)
                sequential_1_global_ = stripdims(sequential_1_global_);
            end
            sequential_1_global_NumDims = 4;
            sequential_1_global_ = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_global_, [4 3 1 2], 4);

            [output, outputNumDims] = Squeeze_To_SoftmaxGraph1074(this, sequential_1_global_, sequential_1_global_NumDims, true);
            output = dr_classifier_efficientnetb0.ops.permuteOutputVar(output, ['as-is'], 2);

            output = dlarray(single(output), repmat('U', 1, max(2, outputNumDims)));
        end

        function [output, outputNumDims1075] = Squeeze_To_SoftmaxGraph1074(this, sequential_1_global_, sequential_1_global_NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_globa_1, sequential_1_globa_1NumDims] = dr_classifier_efficientnetb0.ops.onnxSqueeze(sequential_1_global_, this.Vars.const_axes__1282, sequential_1_global_NumDims);

            % MatMul:
            [sequential_1_dense_4, sequential_1_dense_4NumDims] = dr_classifier_efficientnetb0.ops.onnxMatMul(sequential_1_globa_1, this.sequential_1_dense_3, sequential_1_globa_1NumDims, this.NumDims.sequential_1_dense_3);

            % Add:
            sequential_1_dense_2 = sequential_1_dense_4 + this.Vars.sequential_1_dense_1;
            sequential_1_dense_2NumDims = max(sequential_1_dense_4NumDims, this.NumDims.sequential_1_dense_1);

            % Relu:
            sequential_1_dense_5 = relu(dlarray(sequential_1_dense_2));
            sequential_1_dense_5NumDims = sequential_1_dense_2NumDims;

            % MatMul:
            [sequential_1_dense_9, sequential_1_dense_9NumDims] = dr_classifier_efficientnetb0.ops.onnxMatMul(sequential_1_dense_5, this.sequential_1_dense_8, sequential_1_dense_5NumDims, this.NumDims.sequential_1_dense_8);

            % Add:
            sequential_1_dense_7 = sequential_1_dense_9 + this.Vars.sequential_1_dense_6;
            sequential_1_dense_7NumDims = max(sequential_1_dense_9NumDims, this.NumDims.sequential_1_dense_6);

            % Softmax:
            [output, outputNumDims] = dr_classifier_efficientnetb0.ops.onnxSoftmax13(sequential_1_dense_7, -1, sequential_1_dense_7NumDims);

            % Set graph output arguments
            outputNumDims1075 = outputNumDims;

        end

    end

end