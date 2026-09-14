classdef Squeeze_To_ReshapeLayer1014 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1014';
        end
    end


    methods
        function this = Squeeze_To_ReshapeLayer1014(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_150'};
        end

        function [sequential_1_eff_150] = predict(this, sequential_1_eff_155)
            if isdlarray(sequential_1_eff_155)
                sequential_1_eff_155 = stripdims(sequential_1_eff_155);
            end
            sequential_1_eff_155NumDims = 4;
            sequential_1_eff_155 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_155, [4 3 1 2], 4);

            [sequential_1_eff_150, sequential_1_eff_150NumDims] = Squeeze_To_ReshapeGraph1028(this, sequential_1_eff_155, sequential_1_eff_155NumDims, false);
            sequential_1_eff_150 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_150, [3 4 2 1], 4);

            sequential_1_eff_150 = dlarray(single(sequential_1_eff_150), 'SSCB');
        end

        function [sequential_1_eff_150] = forward(this, sequential_1_eff_155)
            if isdlarray(sequential_1_eff_155)
                sequential_1_eff_155 = stripdims(sequential_1_eff_155);
            end
            sequential_1_eff_155NumDims = 4;
            sequential_1_eff_155 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_155, [4 3 1 2], 4);

            [sequential_1_eff_150, sequential_1_eff_150NumDims] = Squeeze_To_ReshapeGraph1028(this, sequential_1_eff_155, sequential_1_eff_155NumDims, true);
            sequential_1_eff_150 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_150, [3 4 2 1], 4);

            sequential_1_eff_150 = dlarray(single(sequential_1_eff_150), 'SSCB');
        end

        function [sequential_1_eff_150, sequential_1_eff_150NumDims1029] = Squeeze_To_ReshapeGraph1028(this, sequential_1_eff_155, sequential_1_eff_155NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_eff_156, sequential_1_eff_156NumDims] = dr_classifier_efficientnetb0.ops.onnxSqueeze(sequential_1_eff_155, this.Vars.const_axes__1282, sequential_1_eff_155NumDims);

            % Reshape:
            [shape, sequential_1_eff_150NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_156, this.Vars.new_shape__1107, sequential_1_eff_156NumDims, 0);
            sequential_1_eff_150 = reshape(sequential_1_eff_156, shape{:});

            % Set graph output arguments
            sequential_1_eff_150NumDims1029 = sequential_1_eff_150NumDims;

        end

    end

end