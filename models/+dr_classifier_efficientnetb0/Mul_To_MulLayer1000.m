classdef Mul_To_MulLayer1000 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.Mul_To_MulLayer1000';
        end
    end


    methods
        function this = Mul_To_MulLayer1000(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_434'};
        end

        function [sequential_1_eff_434] = predict(this, input)
            if isdlarray(input)
                input = stripdims(input);
            end
            inputNumDims = 4;
            input = dr_classifier_efficientnetb0.ops.permuteInputVar(input, ['as-is'], 4);

            [sequential_1_eff_434, sequential_1_eff_434NumDims] = Mul_To_MulGraph1000(this, input, inputNumDims, false);
            sequential_1_eff_434 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_434, [2 3 4 1], 4);

            sequential_1_eff_434 = dlarray(single(sequential_1_eff_434), 'SSCB');
        end

        function [sequential_1_eff_434] = forward(this, input)
            if isdlarray(input)
                input = stripdims(input);
            end
            inputNumDims = 4;
            input = dr_classifier_efficientnetb0.ops.permuteInputVar(input, ['as-is'], 4);

            [sequential_1_eff_434, sequential_1_eff_434NumDims] = Mul_To_MulGraph1000(this, input, inputNumDims, true);
            sequential_1_eff_434 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_434, [2 3 4 1], 4);

            sequential_1_eff_434 = dlarray(single(sequential_1_eff_434), 'SSCB');
        end

        function [sequential_1_eff_434, sequential_1_eff_434NumDims1001] = Mul_To_MulGraph1000(this, input, inputNumDims, Training)

            % Execute the operators:
            % Mul:
            sequential_1_eff_431 = input .* this.Vars.sequential_1_eff_429;
            sequential_1_eff_431NumDims = max(inputNumDims, this.NumDims.sequential_1_eff_429);

            % Add:
            sequential_1_eff_427 = sequential_1_eff_431 + this.Vars.sequential_1_eff_430;
            sequential_1_eff_427NumDims = max(sequential_1_eff_431NumDims, this.NumDims.sequential_1_eff_430);

            % Mul:
            sequential_1_eff_434 = sequential_1_eff_427 .* this.Vars.sequential_1_eff_428;
            sequential_1_eff_434NumDims = max(sequential_1_eff_427NumDims, this.NumDims.sequential_1_eff_428);

            % Set graph output arguments
            sequential_1_eff_434NumDims1001 = sequential_1_eff_434NumDims;

        end

    end

end