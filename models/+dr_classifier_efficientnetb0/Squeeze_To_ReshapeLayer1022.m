classdef Squeeze_To_ReshapeLayer1022 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1022';
        end
    end


    methods
        function this = Squeeze_To_ReshapeLayer1022(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_257'};
        end

        function [sequential_1_eff_257] = predict(this, sequential_1_eff_262)
            if isdlarray(sequential_1_eff_262)
                sequential_1_eff_262 = stripdims(sequential_1_eff_262);
            end
            sequential_1_eff_262NumDims = 4;
            sequential_1_eff_262 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_262, [4 3 1 2], 4);

            [sequential_1_eff_257, sequential_1_eff_257NumDims] = Squeeze_To_ReshapeGraph1044(this, sequential_1_eff_262, sequential_1_eff_262NumDims, false);
            sequential_1_eff_257 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_257, [3 4 2 1], 4);

            sequential_1_eff_257 = dlarray(single(sequential_1_eff_257), 'SSCB');
        end

        function [sequential_1_eff_257] = forward(this, sequential_1_eff_262)
            if isdlarray(sequential_1_eff_262)
                sequential_1_eff_262 = stripdims(sequential_1_eff_262);
            end
            sequential_1_eff_262NumDims = 4;
            sequential_1_eff_262 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_262, [4 3 1 2], 4);

            [sequential_1_eff_257, sequential_1_eff_257NumDims] = Squeeze_To_ReshapeGraph1044(this, sequential_1_eff_262, sequential_1_eff_262NumDims, true);
            sequential_1_eff_257 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_257, [3 4 2 1], 4);

            sequential_1_eff_257 = dlarray(single(sequential_1_eff_257), 'SSCB');
        end

        function [sequential_1_eff_257, sequential_1_eff_257NumDims1045] = Squeeze_To_ReshapeGraph1044(this, sequential_1_eff_262, sequential_1_eff_262NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_eff_263, sequential_1_eff_263NumDims] = dr_classifier_efficientnetb0.ops.onnxSqueeze(sequential_1_eff_262, this.Vars.const_axes__1282, sequential_1_eff_262NumDims);

            % Reshape:
            [shape, sequential_1_eff_257NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_263, this.Vars.new_shape__1118, sequential_1_eff_263NumDims, 0);
            sequential_1_eff_257 = reshape(sequential_1_eff_263, shape{:});

            % Set graph output arguments
            sequential_1_eff_257NumDims1045 = sequential_1_eff_257NumDims;

        end

    end

end