classdef ReshapeLayer1010 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.ReshapeLayer1010';
        end
    end


    methods
        function this = ReshapeLayer1010(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_effi_91'};
        end

        function [sequential_1_effi_91] = predict(this, sequential_1_eff_100)
            if isdlarray(sequential_1_eff_100)
                sequential_1_eff_100 = stripdims(sequential_1_eff_100);
            end
            sequential_1_eff_100NumDims = 4;
            sequential_1_eff_100 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_100, [4 3 1 2], 4);

            [sequential_1_effi_91, sequential_1_effi_91NumDims] = ReshapeGraph1020(this, sequential_1_eff_100, sequential_1_eff_100NumDims, false);
            sequential_1_effi_91 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_91, [3 4 2 1], 4);

            sequential_1_effi_91 = dlarray(single(sequential_1_effi_91), 'SSCB');
        end

        function [sequential_1_effi_91] = forward(this, sequential_1_eff_100)
            if isdlarray(sequential_1_eff_100)
                sequential_1_eff_100 = stripdims(sequential_1_eff_100);
            end
            sequential_1_eff_100NumDims = 4;
            sequential_1_eff_100 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_100, [4 3 1 2], 4);

            [sequential_1_effi_91, sequential_1_effi_91NumDims] = ReshapeGraph1020(this, sequential_1_eff_100, sequential_1_eff_100NumDims, true);
            sequential_1_effi_91 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_91, [3 4 2 1], 4);

            sequential_1_effi_91 = dlarray(single(sequential_1_effi_91), 'SSCB');
        end

        function [sequential_1_effi_91, sequential_1_effi_91NumDims1021] = ReshapeGraph1020(this, sequential_1_eff_100, sequential_1_eff_100NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape, sequential_1_effi_91NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_100, this.Vars.new_shape__1132, sequential_1_eff_100NumDims, 0);
            sequential_1_effi_91 = reshape(sequential_1_eff_100, shape{:});

            % Set graph output arguments
            sequential_1_effi_91NumDims1021 = sequential_1_effi_91NumDims;

        end

    end

end