classdef ReshapeLayer1007 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.ReshapeLayer1007';
        end
    end


    methods
        function this = ReshapeLayer1007(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_effi_64'};
        end

        function [sequential_1_effi_64] = predict(this, sequential_1_effi_73)
            if isdlarray(sequential_1_effi_73)
                sequential_1_effi_73 = stripdims(sequential_1_effi_73);
            end
            sequential_1_effi_73NumDims = 4;
            sequential_1_effi_73 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_effi_73, [4 3 1 2], 4);

            [sequential_1_effi_64, sequential_1_effi_64NumDims] = ReshapeGraph1014(this, sequential_1_effi_73, sequential_1_effi_73NumDims, false);
            sequential_1_effi_64 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_64, [3 4 2 1], 4);

            sequential_1_effi_64 = dlarray(single(sequential_1_effi_64), 'SSCB');
        end

        function [sequential_1_effi_64] = forward(this, sequential_1_effi_73)
            if isdlarray(sequential_1_effi_73)
                sequential_1_effi_73 = stripdims(sequential_1_effi_73);
            end
            sequential_1_effi_73NumDims = 4;
            sequential_1_effi_73 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_effi_73, [4 3 1 2], 4);

            [sequential_1_effi_64, sequential_1_effi_64NumDims] = ReshapeGraph1014(this, sequential_1_effi_73, sequential_1_effi_73NumDims, true);
            sequential_1_effi_64 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_effi_64, [3 4 2 1], 4);

            sequential_1_effi_64 = dlarray(single(sequential_1_effi_64), 'SSCB');
        end

        function [sequential_1_effi_64, sequential_1_effi_64NumDims1015] = ReshapeGraph1014(this, sequential_1_effi_73, sequential_1_effi_73NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape, sequential_1_effi_64NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_effi_73, this.Vars.new_shape__1132, sequential_1_effi_73NumDims, 0);
            sequential_1_effi_64 = reshape(sequential_1_effi_73, shape{:});

            % Set graph output arguments
            sequential_1_effi_64NumDims1015 = sequential_1_effi_64NumDims;

        end

    end

end