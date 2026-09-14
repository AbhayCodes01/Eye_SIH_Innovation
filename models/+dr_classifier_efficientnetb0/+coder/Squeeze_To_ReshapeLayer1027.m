classdef Squeeze_To_ReshapeLayer1027 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1027(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_efficientnetb0.Squeeze_To_ReshapeLayer1027(cgInstance.Name);
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
        function this = Squeeze_To_ReshapeLayer1027(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'sequential_1_eff_311'};
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

        function [sequential_1_eff_311] = predict(this, sequential_1_eff_316__)
            if isdlarray(sequential_1_eff_316__)
                sequential_1_eff_316_ = stripdims(sequential_1_eff_316__);
            else
                sequential_1_eff_316_ = sequential_1_eff_316__;
            end
            sequential_1_eff_316NumDims = 4;
            sequential_1_eff_316 = dr_classifier_efficientnetb0.coder.ops.permuteInputVar(sequential_1_eff_316_, [4 3 1 2], 4);

            [sequential_1_eff_311__, sequential_1_eff_311NumDims__] = Squeeze_To_ReshapeGraph1054(this, sequential_1_eff_316, sequential_1_eff_316NumDims, false);
            sequential_1_eff_311_ = dr_classifier_efficientnetb0.coder.ops.permuteOutputVar(sequential_1_eff_311__, [3 4 2 1], 4);

            sequential_1_eff_311 = dlarray(single(sequential_1_eff_311_), 'SSCB');
        end

        function [sequential_1_eff_311, sequential_1_eff_311NumDims1055] = Squeeze_To_ReshapeGraph1054(this, sequential_1_eff_316, sequential_1_eff_316NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_eff_317, sequential_1_eff_317NumDims] = dr_classifier_efficientnetb0.coder.ops.onnxSqueeze(sequential_1_eff_316, this.Vars.const_axes__1282, coder.const(sequential_1_eff_316NumDims));

            % Reshape:
            [shape1022, sequential_1_eff_311NumDims] = dr_classifier_efficientnetb0.coder.ops.prepareReshapeArgs(sequential_1_eff_317, this.Vars.new_shape__1118, coder.const(sequential_1_eff_317NumDims), 0);
            sequential_1_eff_311 = reshape(sequential_1_eff_317, shape1022{:});

            % Set graph output arguments
            sequential_1_eff_311NumDims1055 = coder.const(sequential_1_eff_311NumDims);

        end

    end

end