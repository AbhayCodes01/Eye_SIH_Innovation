classdef Squeeze_To_ReshapeLayer1009 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1009(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_efficientnetb0.Squeeze_To_ReshapeLayer1009(cgInstance.Name);
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
        function this = Squeeze_To_ReshapeLayer1009(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'sequential_1_effi_96'};
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

        function [sequential_1_effi_96] = predict(this, sequential_1_eff_101__)
            if isdlarray(sequential_1_eff_101__)
                sequential_1_eff_101_ = stripdims(sequential_1_eff_101__);
            else
                sequential_1_eff_101_ = sequential_1_eff_101__;
            end
            sequential_1_eff_101NumDims = 4;
            sequential_1_eff_101 = dr_classifier_efficientnetb0.coder.ops.permuteInputVar(sequential_1_eff_101_, [4 3 1 2], 4);

            [sequential_1_effi_96__, sequential_1_effi_96NumDims__] = Squeeze_To_ReshapeGraph1018(this, sequential_1_eff_101, sequential_1_eff_101NumDims, false);
            sequential_1_effi_96_ = dr_classifier_efficientnetb0.coder.ops.permuteOutputVar(sequential_1_effi_96__, [3 4 2 1], 4);

            sequential_1_effi_96 = dlarray(single(sequential_1_effi_96_), 'SSCB');
        end

        function [sequential_1_effi_96, sequential_1_effi_96NumDims1019] = Squeeze_To_ReshapeGraph1018(this, sequential_1_eff_101, sequential_1_eff_101NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_eff_102, sequential_1_eff_102NumDims] = dr_classifier_efficientnetb0.coder.ops.onnxSqueeze(sequential_1_eff_101, this.Vars.const_axes__1282, coder.const(sequential_1_eff_101NumDims));

            % Reshape:
            [shape1006, sequential_1_effi_96NumDims] = dr_classifier_efficientnetb0.coder.ops.prepareReshapeArgs(sequential_1_eff_102, this.Vars.new_shape__1130, coder.const(sequential_1_eff_102NumDims), 0);
            sequential_1_effi_96 = reshape(sequential_1_eff_102, shape1006{:});

            % Set graph output arguments
            sequential_1_effi_96NumDims1019 = coder.const(sequential_1_effi_96NumDims);

        end

    end

end