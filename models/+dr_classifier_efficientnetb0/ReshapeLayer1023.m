classdef ReshapeLayer1023 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.ReshapeLayer1023';
        end
    end


    methods
        function this = ReshapeLayer1023(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_252'};
        end

        function [sequential_1_eff_252] = predict(this, sequential_1_eff_261)
            if isdlarray(sequential_1_eff_261)
                sequential_1_eff_261 = stripdims(sequential_1_eff_261);
            end
            sequential_1_eff_261NumDims = 4;
            sequential_1_eff_261 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_261, [4 3 1 2], 4);

            [sequential_1_eff_252, sequential_1_eff_252NumDims] = ReshapeGraph1046(this, sequential_1_eff_261, sequential_1_eff_261NumDims, false);
            sequential_1_eff_252 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_252, [3 4 2 1], 4);

            sequential_1_eff_252 = dlarray(single(sequential_1_eff_252), 'SSCB');
        end

        function [sequential_1_eff_252] = forward(this, sequential_1_eff_261)
            if isdlarray(sequential_1_eff_261)
                sequential_1_eff_261 = stripdims(sequential_1_eff_261);
            end
            sequential_1_eff_261NumDims = 4;
            sequential_1_eff_261 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_261, [4 3 1 2], 4);

            [sequential_1_eff_252, sequential_1_eff_252NumDims] = ReshapeGraph1046(this, sequential_1_eff_261, sequential_1_eff_261NumDims, true);
            sequential_1_eff_252 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_252, [3 4 2 1], 4);

            sequential_1_eff_252 = dlarray(single(sequential_1_eff_252), 'SSCB');
        end

        function [sequential_1_eff_252, sequential_1_eff_252NumDims1047] = ReshapeGraph1046(this, sequential_1_eff_261, sequential_1_eff_261NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape, sequential_1_eff_252NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_261, this.Vars.new_shape__1111, sequential_1_eff_261NumDims, 0);
            sequential_1_eff_252 = reshape(sequential_1_eff_261, shape{:});

            % Set graph output arguments
            sequential_1_eff_252NumDims1047 = sequential_1_eff_252NumDims;

        end

    end

end