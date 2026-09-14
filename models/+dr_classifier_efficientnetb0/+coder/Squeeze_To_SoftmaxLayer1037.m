classdef Squeeze_To_SoftmaxLayer1037 < nnet.layer.Layer & nnet.layer.Formattable
    % A custom layer auto-generated while importing an ONNX network.
    %#codegen

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
        % Specify the properties of the class that will not be modified
        % after the first assignment.
        function p = matlabCodegenNontunableProperties(~)
            p = {
                % Constants, i.e., Vars, NumDims and all learnables and states
                'Vars'
                'NumDims'
                };
        end
    end


    methods(Static, Hidden)
        % Instantiate a codegenable layer instance from a MATLAB layer instance
        function this_cg = matlabCodegenToRedirected(mlInstance)
            this_cg = dr_classifier_efficientnetb0.coder.Squeeze_To_SoftmaxLayer1037(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_efficientnetb0.Squeeze_To_SoftmaxLayer1037(cgInstance.Name);
            if isstruct(cgInstance.Vars)
                names = fieldnames(cgInstance.Vars);
                for i=1:numel(names)
                    fieldname = names{i};
                    this_ml.Vars.(fieldname) = dlarray(cgInstance.Vars.(fieldname));
                end
            else
                this_ml.Vars = [];
            end
            this_ml.NumDims = cgInstance.NumDims;
            this_ml.sequential_1_dense_3 = cgInstance.sequential_1_dense_3;
            this_ml.sequential_1_dense_8 = cgInstance.sequential_1_dense_8;
        end
    end

    methods
        function this = Squeeze_To_SoftmaxLayer1037(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'output'};
            if isstruct(mlInstance.Vars)
                names = fieldnames(mlInstance.Vars);
                for i=1:numel(names)
                    fieldname = names{i};
                    this.Vars.(fieldname) = dr_classifier_efficientnetb0.coder.ops.extractIfDlarray(mlInstance.Vars.(fieldname));
                end
            else
                this.Vars = [];
            end

            this.NumDims = mlInstance.NumDims;
            this.sequential_1_dense_3 = mlInstance.sequential_1_dense_3;
            this.sequential_1_dense_8 = mlInstance.sequential_1_dense_8;
        end

        function [output] = predict(this, sequential_1_global___)
            if isdlarray(sequential_1_global___)
                sequential_1_global__ = stripdims(sequential_1_global___);
            else
                sequential_1_global__ = sequential_1_global___;
            end
            sequential_1_global_NumDims = 4;
            sequential_1_global_ = dr_classifier_efficientnetb0.coder.ops.permuteInputVar(sequential_1_global__, [4 3 1 2], 4);

            [output__, outputNumDims__] = Squeeze_To_SoftmaxGraph1074(this, sequential_1_global_, sequential_1_global_NumDims, false);
            output_ = dr_classifier_efficientnetb0.coder.ops.permuteOutputVar(output__, ['as-is'], 2);

            output = dlarray(single(output_), repmat('U', 1, max(2, coder.const(outputNumDims__))));
        end

        function [output, outputNumDims1075] = Squeeze_To_SoftmaxGraph1074(this, sequential_1_global_, sequential_1_global_NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_globa_1, sequential_1_globa_1NumDims] = dr_classifier_efficientnetb0.coder.ops.onnxSqueeze(sequential_1_global_, this.Vars.const_axes__1282, coder.const(sequential_1_global_NumDims));

            % MatMul:
            [sequential_1_dense_4, sequential_1_dense_4NumDims] = dr_classifier_efficientnetb0.coder.ops.onnxMatMul(sequential_1_globa_1, this.sequential_1_dense_3, coder.const(sequential_1_globa_1NumDims), this.NumDims.sequential_1_dense_3);

            % Add:
            sequential_1_dense_2 = sequential_1_dense_4 + this.Vars.sequential_1_dense_1;
            sequential_1_dense_2NumDims = max(coder.const(sequential_1_dense_4NumDims), this.NumDims.sequential_1_dense_1);

            % Relu:
            X1032 = dlarray(dr_classifier_efficientnetb0.coder.ops.extractIfDlarray(sequential_1_dense_2));
            Y1033 = relu(X1032);
            sequential_1_dense_5 = dr_classifier_efficientnetb0.coder.ops.extractIfDlarray(Y1033);
            sequential_1_dense_5NumDims = coder.const(sequential_1_dense_2NumDims);

            % MatMul:
            [sequential_1_dense_9, sequential_1_dense_9NumDims] = dr_classifier_efficientnetb0.coder.ops.onnxMatMul(sequential_1_dense_5, this.sequential_1_dense_8, coder.const(sequential_1_dense_5NumDims), this.NumDims.sequential_1_dense_8);

            % Add:
            sequential_1_dense_7 = sequential_1_dense_9 + this.Vars.sequential_1_dense_6;
            sequential_1_dense_7NumDims = max(coder.const(sequential_1_dense_9NumDims), this.NumDims.sequential_1_dense_6);

            % Softmax:
            [output, outputNumDims] = dr_classifier_efficientnetb0.coder.ops.onnxSoftmax13(sequential_1_dense_7, -1, coder.const(sequential_1_dense_7NumDims));

            % Set graph output arguments
            outputNumDims1075 = coder.const(outputNumDims);

        end

    end

end