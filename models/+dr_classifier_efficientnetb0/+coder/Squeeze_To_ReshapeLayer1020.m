classdef Squeeze_To_ReshapeLayer1020 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1020(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_efficientnetb0.Squeeze_To_ReshapeLayer1020(cgInstance.Name);
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
        function this = Squeeze_To_ReshapeLayer1020(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'sequential_1_eff_230'};
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

        function [sequential_1_eff_230] = predict(this, sequential_1_eff_235__)
            if isdlarray(sequential_1_eff_235__)
                sequential_1_eff_235_ = stripdims(sequential_1_eff_235__);
            else
                sequential_1_eff_235_ = sequential_1_eff_235__;
            end
            sequential_1_eff_235NumDims = 4;
            sequential_1_eff_235 = dr_classifier_efficientnetb0.coder.ops.permuteInputVar(sequential_1_eff_235_, [4 3 1 2], 4);

            [sequential_1_eff_230__, sequential_1_eff_230NumDims__] = Squeeze_To_ReshapeGraph1040(this, sequential_1_eff_235, sequential_1_eff_235NumDims, false);
            sequential_1_eff_230_ = dr_classifier_efficientnetb0.coder.ops.permuteOutputVar(sequential_1_eff_230__, [3 4 2 1], 4);

            sequential_1_eff_230 = dlarray(single(sequential_1_eff_230_), 'SSCB');
        end

        function [sequential_1_eff_230, sequential_1_eff_230NumDims1041] = Squeeze_To_ReshapeGraph1040(this, sequential_1_eff_235, sequential_1_eff_235NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_eff_236, sequential_1_eff_236NumDims] = dr_classifier_efficientnetb0.coder.ops.onnxSqueeze(sequential_1_eff_235, this.Vars.const_axes__1282, coder.const(sequential_1_eff_235NumDims));

            % Reshape:
            [shape1016, sequential_1_eff_230NumDims] = dr_classifier_efficientnetb0.coder.ops.prepareReshapeArgs(sequential_1_eff_236, this.Vars.new_shape__1124, coder.const(sequential_1_eff_236NumDims), 0);
            sequential_1_eff_230 = reshape(sequential_1_eff_236, shape1016{:});

            % Set graph output arguments
            sequential_1_eff_230NumDims1041 = coder.const(sequential_1_eff_230NumDims);

        end

    end

end