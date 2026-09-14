classdef ReshapeLayer1005 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.ReshapeLayer1005';
        end
    end


    methods
        function this = ReshapeLayer1005(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_effi_37'};
        end

        function [sequential_1_effi_37] = predict(this, sequential_1_effi_46)
            if isdlarray(sequential_1_effi_46)
                sequential_1_effi_46 = stripdims(sequential_1_effi_46);
            end
            sequential_1_effi_46NumDims = 4;
            sequential_1_effi_46 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_effi_46, [4 3 1 2], 4);

            [sequential_1_effi_37, sequential_1_effi_37NumDims] = ReshapeGraph1010(this, sequential_1_effi_46, sequential_1_effi_46NumDims, false);
            sequential_1_effi_37 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_37, [3 4 2 1], 4);

            sequential_1_effi_37 = dlarray(single(sequential_1_effi_37), 'SSCB');
        end

        function [sequential_1_effi_37] = forward(this, sequential_1_effi_46)
            if isdlarray(sequential_1_effi_46)
                sequential_1_effi_46 = stripdims(sequential_1_effi_46);
            end
            sequential_1_effi_46NumDims = 4;
            sequential_1_effi_46 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_effi_46, [4 3 1 2], 4);

            [sequential_1_effi_37, sequential_1_effi_37NumDims] = ReshapeGraph1010(this, sequential_1_effi_46, sequential_1_effi_46NumDims, true);
            sequential_1_effi_37 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_37, [3 4 2 1], 4);

            sequential_1_effi_37 = dlarray(single(sequential_1_effi_37), 'SSCB');
        end

        function [sequential_1_effi_37, sequential_1_effi_37NumDims1011] = ReshapeGraph1010(this, sequential_1_effi_46, sequential_1_effi_46NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape, sequential_1_effi_37NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_effi_46, this.Vars.new_shape__1113, sequential_1_effi_46NumDims, 0);
            sequential_1_effi_37 = reshape(sequential_1_effi_46, shape{:});

            % Set graph output arguments
            sequential_1_effi_37NumDims1011 = sequential_1_effi_37NumDims;

        end

    end

end