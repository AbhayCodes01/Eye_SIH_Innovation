classdef Squeeze_To_ReshapeLayer1006 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1006';
        end
    end


    methods
        function this = Squeeze_To_ReshapeLayer1006(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_effi_69'};
        end

        function [sequential_1_effi_69] = predict(this, sequential_1_effi_74)
            if isdlarray(sequential_1_effi_74)
                sequential_1_effi_74 = stripdims(sequential_1_effi_74);
            end
            sequential_1_effi_74NumDims = 4;
            sequential_1_effi_74 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_effi_74, [4 3 1 2], 4);

            [sequential_1_effi_69, sequential_1_effi_69NumDims] = Squeeze_To_ReshapeGraph1012(this, sequential_1_effi_74, sequential_1_effi_74NumDims, false);
            sequential_1_effi_69 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_69, [3 4 2 1], 4);

            sequential_1_effi_69 = dlarray(single(sequential_1_effi_69), 'SSCB');
        end

        function [sequential_1_effi_69] = forward(this, sequential_1_effi_74)
            if isdlarray(sequential_1_effi_74)
                sequential_1_effi_74 = stripdims(sequential_1_effi_74);
            end
            sequential_1_effi_74NumDims = 4;
            sequential_1_effi_74 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_effi_74, [4 3 1 2], 4);

            [sequential_1_effi_69, sequential_1_effi_69NumDims] = Squeeze_To_ReshapeGraph1012(this, sequential_1_effi_74, sequential_1_effi_74NumDims, true);
            sequential_1_effi_69 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_69, [3 4 2 1], 4);

            sequential_1_effi_69 = dlarray(single(sequential_1_effi_69), 'SSCB');
        end

        function [sequential_1_effi_69, sequential_1_effi_69NumDims1013] = Squeeze_To_ReshapeGraph1012(this, sequential_1_effi_74, sequential_1_effi_74NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_effi_75, sequential_1_effi_75NumDims] = dr_classifier_efficientnetb0.ops.onnxSqueeze(sequential_1_effi_74, this.Vars.const_axes__1282, sequential_1_effi_74NumDims);

            % Reshape:
            [shape, sequential_1_effi_69NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_effi_75, this.Vars.new_shape__1130, sequential_1_effi_75NumDims, 0);
            sequential_1_effi_69 = reshape(sequential_1_effi_75, shape{:});

            % Set graph output arguments
            sequential_1_effi_69NumDims1013 = sequential_1_effi_69NumDims;

        end

    end

end