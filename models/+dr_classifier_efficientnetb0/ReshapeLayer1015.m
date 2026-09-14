classdef ReshapeLayer1015 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.ReshapeLayer1015';
        end
    end


    methods
        function this = ReshapeLayer1015(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_145'};
        end

        function [sequential_1_eff_145] = predict(this, sequential_1_eff_154)
            if isdlarray(sequential_1_eff_154)
                sequential_1_eff_154 = stripdims(sequential_1_eff_154);
            end
            sequential_1_eff_154NumDims = 4;
            sequential_1_eff_154 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_154, [4 3 1 2], 4);

            [sequential_1_eff_145, sequential_1_eff_145NumDims] = ReshapeGraph1030(this, sequential_1_eff_154, sequential_1_eff_154NumDims, false);
            sequential_1_eff_145 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_145, [3 4 2 1], 4);

            sequential_1_eff_145 = dlarray(single(sequential_1_eff_145), 'SSCB');
        end

        function [sequential_1_eff_145] = forward(this, sequential_1_eff_154)
            if isdlarray(sequential_1_eff_154)
                sequential_1_eff_154 = stripdims(sequential_1_eff_154);
            end
            sequential_1_eff_154NumDims = 4;
            sequential_1_eff_154 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_154, [4 3 1 2], 4);

            [sequential_1_eff_145, sequential_1_eff_145NumDims] = ReshapeGraph1030(this, sequential_1_eff_154, sequential_1_eff_154NumDims, true);
            sequential_1_eff_145 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_145, [3 4 2 1], 4);

            sequential_1_eff_145 = dlarray(single(sequential_1_eff_145), 'SSCB');
        end

        function [sequential_1_eff_145, sequential_1_eff_145NumDims1031] = ReshapeGraph1030(this, sequential_1_eff_154, sequential_1_eff_154NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape, sequential_1_eff_145NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_154, this.Vars.new_shape__1100, sequential_1_eff_154NumDims, 0);
            sequential_1_eff_145 = reshape(sequential_1_eff_154, shape{:});

            % Set graph output arguments
            sequential_1_eff_145NumDims1031 = sequential_1_eff_145NumDims;

        end

    end

end