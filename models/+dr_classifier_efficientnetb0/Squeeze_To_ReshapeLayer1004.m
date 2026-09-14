classdef Squeeze_To_ReshapeLayer1004 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1004';
        end
    end


    methods
        function this = Squeeze_To_ReshapeLayer1004(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_effi_42'};
        end

        function [sequential_1_effi_42] = predict(this, sequential_1_effi_47)
            if isdlarray(sequential_1_effi_47)
                sequential_1_effi_47 = stripdims(sequential_1_effi_47);
            end
            sequential_1_effi_47NumDims = 4;
            sequential_1_effi_47 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_effi_47, [4 3 1 2], 4);

            [sequential_1_effi_42, sequential_1_effi_42NumDims] = Squeeze_To_ReshapeGraph1008(this, sequential_1_effi_47, sequential_1_effi_47NumDims, false);
            sequential_1_effi_42 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_42, [3 4 2 1], 4);

            sequential_1_effi_42 = dlarray(single(sequential_1_effi_42), 'SSCB');
        end

        function [sequential_1_effi_42] = forward(this, sequential_1_effi_47)
            if isdlarray(sequential_1_effi_47)
                sequential_1_effi_47 = stripdims(sequential_1_effi_47);
            end
            sequential_1_effi_47NumDims = 4;
            sequential_1_effi_47 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_effi_47, [4 3 1 2], 4);

            [sequential_1_effi_42, sequential_1_effi_42NumDims] = Squeeze_To_ReshapeGraph1008(this, sequential_1_effi_47, sequential_1_effi_47NumDims, true);
            sequential_1_effi_42 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_42, [3 4 2 1], 4);

            sequential_1_effi_42 = dlarray(single(sequential_1_effi_42), 'SSCB');
        end

        function [sequential_1_effi_42, sequential_1_effi_42NumDims1009] = Squeeze_To_ReshapeGraph1008(this, sequential_1_effi_47, sequential_1_effi_47NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_effi_48, sequential_1_effi_48NumDims] = dr_classifier_efficientnetb0.ops.onnxSqueeze(sequential_1_effi_47, this.Vars.const_axes__1282, sequential_1_effi_47NumDims);

            % Reshape:
            [shape, sequential_1_effi_42NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_effi_48, this.Vars.new_shape__1112, sequential_1_effi_48NumDims, 0);
            sequential_1_effi_42 = reshape(sequential_1_effi_48, shape{:});

            % Set graph output arguments
            sequential_1_effi_42NumDims1009 = sequential_1_effi_42NumDims;

        end

    end

end