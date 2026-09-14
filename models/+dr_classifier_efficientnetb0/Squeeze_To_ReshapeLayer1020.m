classdef Squeeze_To_ReshapeLayer1020 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1020';
        end
    end


    methods
        function this = Squeeze_To_ReshapeLayer1020(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_230'};
        end

        function [sequential_1_eff_230] = predict(this, sequential_1_eff_235)
            if isdlarray(sequential_1_eff_235)
                sequential_1_eff_235 = stripdims(sequential_1_eff_235);
            end
            sequential_1_eff_235NumDims = 4;
            sequential_1_eff_235 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_235, [4 3 1 2], 4);

            [sequential_1_eff_230, sequential_1_eff_230NumDims] = Squeeze_To_ReshapeGraph1040(this, sequential_1_eff_235, sequential_1_eff_235NumDims, false);
            sequential_1_eff_230 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_230, [3 4 2 1], 4);

            sequential_1_eff_230 = dlarray(single(sequential_1_eff_230), 'SSCB');
        end

        function [sequential_1_eff_230] = forward(this, sequential_1_eff_235)
            if isdlarray(sequential_1_eff_235)
                sequential_1_eff_235 = stripdims(sequential_1_eff_235);
            end
            sequential_1_eff_235NumDims = 4;
            sequential_1_eff_235 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_235, [4 3 1 2], 4);

            [sequential_1_eff_230, sequential_1_eff_230NumDims] = Squeeze_To_ReshapeGraph1040(this, sequential_1_eff_235, sequential_1_eff_235NumDims, true);
            sequential_1_eff_230 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_230, [3 4 2 1], 4);

            sequential_1_eff_230 = dlarray(single(sequential_1_eff_230), 'SSCB');
        end

        function [sequential_1_eff_230, sequential_1_eff_230NumDims1041] = Squeeze_To_ReshapeGraph1040(this, sequential_1_eff_235, sequential_1_eff_235NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_eff_236, sequential_1_eff_236NumDims] = dr_classifier_efficientnetb0.ops.onnxSqueeze(sequential_1_eff_235, this.Vars.const_axes__1282, sequential_1_eff_235NumDims);

            % Reshape:
            [shape, sequential_1_eff_230NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_236, this.Vars.new_shape__1124, sequential_1_eff_236NumDims, 0);
            sequential_1_eff_230 = reshape(sequential_1_eff_236, shape{:});

            % Set graph output arguments
            sequential_1_eff_230NumDims1041 = sequential_1_eff_230NumDims;

        end

    end

end