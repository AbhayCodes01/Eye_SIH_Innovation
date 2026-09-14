classdef Squeeze_To_ReshapeLayer1001 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1001';
        end
    end


    methods
        function this = Squeeze_To_ReshapeLayer1001(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_effi_15'};
        end

        function [sequential_1_effi_15] = predict(this, sequential_1_effi_20)
            if isdlarray(sequential_1_effi_20)
                sequential_1_effi_20 = stripdims(sequential_1_effi_20);
            end
            sequential_1_effi_20NumDims = 4;
            sequential_1_effi_20 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_effi_20, [4 3 1 2], 4);

            [sequential_1_effi_15, sequential_1_effi_15NumDims] = Squeeze_To_ReshapeGraph1002(this, sequential_1_effi_20, sequential_1_effi_20NumDims, false);
            sequential_1_effi_15 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_15, [3 4 2 1], 4);

            sequential_1_effi_15 = dlarray(single(sequential_1_effi_15), 'SSCB');
        end

        function [sequential_1_effi_15] = forward(this, sequential_1_effi_20)
            if isdlarray(sequential_1_effi_20)
                sequential_1_effi_20 = stripdims(sequential_1_effi_20);
            end
            sequential_1_effi_20NumDims = 4;
            sequential_1_effi_20 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_effi_20, [4 3 1 2], 4);

            [sequential_1_effi_15, sequential_1_effi_15NumDims] = Squeeze_To_ReshapeGraph1002(this, sequential_1_effi_20, sequential_1_effi_20NumDims, true);
            sequential_1_effi_15 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_15, [3 4 2 1], 4);

            sequential_1_effi_15 = dlarray(single(sequential_1_effi_15), 'SSCB');
        end

        function [sequential_1_effi_15, sequential_1_effi_15NumDims1003] = Squeeze_To_ReshapeGraph1002(this, sequential_1_effi_20, sequential_1_effi_20NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_effi_21, sequential_1_effi_21NumDims] = dr_classifier_efficientnetb0.ops.onnxSqueeze(sequential_1_effi_20, this.Vars.const_axes__1282, sequential_1_effi_20NumDims);

            % Reshape:
            [shape, sequential_1_effi_15NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_effi_21, this.Vars.new_shape__1103, sequential_1_effi_21NumDims, 0);
            sequential_1_effi_15 = reshape(sequential_1_effi_21, shape{:});

            % Set graph output arguments
            sequential_1_effi_15NumDims1003 = sequential_1_effi_15NumDims;

        end

    end

end