classdef Mul_To_MulLayer1000 < nnet.layer.Layer & nnet.layer.Formattable
    % A custom layer auto-generated while importing an ONNX network.
    %#codegen

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
        % Specify the properties of the class that will not be modified
        % after the first assignment.
        function p = matlabCodegenNontunableProperties(~)
            p = {
                % Constants, i.e., Vars, NumDims and all learnables and states
                'Vars'
                'NumDims'
                };
        end
    end


    methods(Static, Hidden)
        % Instantiate a codegenable layer instance from a MATLAB layer instance
        function this_cg = matlabCodegenToRedirected(mlInstance)
            this_cg = dr_classifier_efficientnetb0.coder.Mul_To_MulLayer1000(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_efficientnetb0.Mul_To_MulLayer1000(cgInstance.Name);
            if isstruct(cgInstance.Vars)
                names = fieldnames(cgInstance.Vars);
                for i=1:numel(names)
                    fieldname = names{i};
                    this_ml.Vars.(fieldname) = dlarray(cgInstance.Vars.(fieldname));
                end
            else
                this_ml.Vars = [];
            end
            this_ml.NumDims = cgInstance.NumDims;
        end
    end

    methods
        function this = Mul_To_MulLayer1000(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'sequential_1_eff_434'};
            if isstruct(mlInstance.Vars)
                names = fieldnames(mlInstance.Vars);
                for i=1:numel(names)
                    fieldname = names{i};
                    this.Vars.(fieldname) = dr_classifier_efficientnetb0.coder.ops.extractIfDlarray(mlInstance.Vars.(fieldname));
                end
            else
                this.Vars = [];
            end

            this.NumDims = mlInstance.NumDims;
        end

        function [sequential_1_eff_434] = predict(this, input__)
            if isdlarray(input__)
                input_ = stripdims(input__);
            else
                input_ = input__;
            end
            inputNumDims = 4;
            input = dr_classifier_efficientnetb0.coder.ops.permuteInputVar(input_, ['as-is'], 4);

            [sequential_1_eff_434__, sequential_1_eff_434NumDims__] = Mul_To_MulGraph1000(this, input, inputNumDims, false);
            sequential_1_eff_434_ = dr_classifier_efficientnetb0.coder.ops.permuteOutputVar(sequential_1_eff_434__, [2 3 4 1], 4);

            sequential_1_eff_434 = dlarray(single(sequential_1_eff_434_), 'SSCB');
        end

        function [sequential_1_eff_434, sequential_1_eff_434NumDims1001] = Mul_To_MulGraph1000(this, input, inputNumDims, Training)

            % Execute the operators:
            % Mul:
            sequential_1_eff_431 = input .* this.Vars.sequential_1_eff_429;
            sequential_1_eff_431NumDims = max(coder.const(inputNumDims), this.NumDims.sequential_1_eff_429);

            % Add:
            sequential_1_eff_427 = sequential_1_eff_431 + this.Vars.sequential_1_eff_430;
            sequential_1_eff_427NumDims = max(coder.const(sequential_1_eff_431NumDims), this.NumDims.sequential_1_eff_430);

            % Mul:
            sequential_1_eff_434 = sequential_1_eff_427 .* this.Vars.sequential_1_eff_428;
            sequential_1_eff_434NumDims = max(coder.const(sequential_1_eff_427NumDims), this.NumDims.sequential_1_eff_428);

            % Set graph output arguments
            sequential_1_eff_434NumDims1001 = coder.const(sequential_1_eff_434NumDims);

        end

    end

end