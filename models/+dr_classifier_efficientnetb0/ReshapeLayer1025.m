classdef ReshapeLayer1025 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.ReshapeLayer1025';
        end
    end


    methods
        function this = ReshapeLayer1025(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_279'};
        end

        function [sequential_1_eff_279] = predict(this, sequential_1_eff_288)
            if isdlarray(sequential_1_eff_288)
                sequential_1_eff_288 = stripdims(sequential_1_eff_288);
            end
            sequential_1_eff_288NumDims = 4;
            sequential_1_eff_288 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_288, [4 3 1 2], 4);

            [sequential_1_eff_279, sequential_1_eff_279NumDims] = ReshapeGraph1050(this, sequential_1_eff_288, sequential_1_eff_288NumDims, false);
            sequential_1_eff_279 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_279, [3 4 2 1], 4);

            sequential_1_eff_279 = dlarray(single(sequential_1_eff_279), 'SSCB');
        end

        function [sequential_1_eff_279] = forward(this, sequential_1_eff_288)
            if isdlarray(sequential_1_eff_288)
                sequential_1_eff_288 = stripdims(sequential_1_eff_288);
            end
            sequential_1_eff_288NumDims = 4;
            sequential_1_eff_288 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_288, [4 3 1 2], 4);

            [sequential_1_eff_279, sequential_1_eff_279NumDims] = ReshapeGraph1050(this, sequential_1_eff_288, sequential_1_eff_288NumDims, true);
            sequential_1_eff_279 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_279, [3 4 2 1], 4);

            sequential_1_eff_279 = dlarray(single(sequential_1_eff_279), 'SSCB');
        end

        function [sequential_1_eff_279, sequential_1_eff_279NumDims1051] = ReshapeGraph1050(this, sequential_1_eff_288, sequential_1_eff_288NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape, sequential_1_eff_279NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_288, this.Vars.new_shape__1111, sequential_1_eff_288NumDims, 0);
            sequential_1_eff_279 = reshape(sequential_1_eff_288, shape{:});

            % Set graph output arguments
            sequential_1_eff_279NumDims1051 = sequential_1_eff_279NumDims;

        end

    end

end