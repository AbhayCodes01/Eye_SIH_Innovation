classdef ReshapeLayer1019 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.ReshapeLayer1019';
        end
    end


    methods
        function this = ReshapeLayer1019(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_199'};
        end

        function [sequential_1_eff_199] = predict(this, sequential_1_eff_208)
            if isdlarray(sequential_1_eff_208)
                sequential_1_eff_208 = stripdims(sequential_1_eff_208);
            end
            sequential_1_eff_208NumDims = 4;
            sequential_1_eff_208 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_208, [4 3 1 2], 4);

            [sequential_1_eff_199, sequential_1_eff_199NumDims] = ReshapeGraph1038(this, sequential_1_eff_208, sequential_1_eff_208NumDims, false);
            sequential_1_eff_199 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_199, [3 4 2 1], 4);

            sequential_1_eff_199 = dlarray(single(sequential_1_eff_199), 'SSCB');
        end

        function [sequential_1_eff_199] = forward(this, sequential_1_eff_208)
            if isdlarray(sequential_1_eff_208)
                sequential_1_eff_208 = stripdims(sequential_1_eff_208);
            end
            sequential_1_eff_208NumDims = 4;
            sequential_1_eff_208 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_208, [4 3 1 2], 4);

            [sequential_1_eff_199, sequential_1_eff_199NumDims] = ReshapeGraph1038(this, sequential_1_eff_208, sequential_1_eff_208NumDims, true);
            sequential_1_eff_199 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_199, [3 4 2 1], 4);

            sequential_1_eff_199 = dlarray(single(sequential_1_eff_199), 'SSCB');
        end

        function [sequential_1_eff_199, sequential_1_eff_199NumDims1039] = ReshapeGraph1038(this, sequential_1_eff_208, sequential_1_eff_208NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape, sequential_1_eff_199NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_208, this.Vars.new_shape__1139, sequential_1_eff_208NumDims, 0);
            sequential_1_eff_199 = reshape(sequential_1_eff_208, shape{:});

            % Set graph output arguments
            sequential_1_eff_199NumDims1039 = sequential_1_eff_199NumDims;

        end

    end

end