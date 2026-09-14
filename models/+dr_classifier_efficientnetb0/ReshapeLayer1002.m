classdef ReshapeLayer1002 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.ReshapeLayer1002';
        end
    end


    methods
        function this = ReshapeLayer1002(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_effi_10'};
        end

        function [sequential_1_effi_10] = predict(this, sequential_1_effi_19)
            if isdlarray(sequential_1_effi_19)
                sequential_1_effi_19 = stripdims(sequential_1_effi_19);
            end
            sequential_1_effi_19NumDims = 4;
            sequential_1_effi_19 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_effi_19, [4 3 1 2], 4);

            [sequential_1_effi_10, sequential_1_effi_10NumDims] = ReshapeGraph1004(this, sequential_1_effi_19, sequential_1_effi_19NumDims, false);
            sequential_1_effi_10 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_10, [3 4 2 1], 4);

            sequential_1_effi_10 = dlarray(single(sequential_1_effi_10), 'SSCB');
        end

        function [sequential_1_effi_10] = forward(this, sequential_1_effi_19)
            if isdlarray(sequential_1_effi_19)
                sequential_1_effi_19 = stripdims(sequential_1_effi_19);
            end
            sequential_1_effi_19NumDims = 4;
            sequential_1_effi_19 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_effi_19, [4 3 1 2], 4);

            [sequential_1_effi_10, sequential_1_effi_10NumDims] = ReshapeGraph1004(this, sequential_1_effi_19, sequential_1_effi_19NumDims, true);
            sequential_1_effi_10 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_10, [3 4 2 1], 4);

            sequential_1_effi_10 = dlarray(single(sequential_1_effi_10), 'SSCB');
        end

        function [sequential_1_effi_10, sequential_1_effi_10NumDims1005] = ReshapeGraph1004(this, sequential_1_effi_19, sequential_1_effi_19NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape, sequential_1_effi_10NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_effi_19, this.Vars.new_shape__1104, sequential_1_effi_19NumDims, 0);
            sequential_1_effi_10 = reshape(sequential_1_effi_19, shape{:});

            % Set graph output arguments
            sequential_1_effi_10NumDims1005 = sequential_1_effi_10NumDims;

        end

    end

end