classdef Squeeze_To_ReshapeLayer1033 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1033(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_efficientnetb0.Squeeze_To_ReshapeLayer1033(cgInstance.Name);
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
        function this = Squeeze_To_ReshapeLayer1033(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'sequential_1_eff_392'};
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

        function [sequential_1_eff_392] = predict(this, sequential_1_eff_397__)
            if isdlarray(sequential_1_eff_397__)
                sequential_1_eff_397_ = stripdims(sequential_1_eff_397__);
            else
                sequential_1_eff_397_ = sequential_1_eff_397__;
            end
            sequential_1_eff_397NumDims = 4;
            sequential_1_eff_397 = dr_classifier_efficientnetb0.coder.ops.permuteInputVar(sequential_1_eff_397_, [4 3 1 2], 4);

            [sequential_1_eff_392__, sequential_1_eff_392NumDims__] = Squeeze_To_ReshapeGraph1066(this, sequential_1_eff_397, sequential_1_eff_397NumDims, false);
            sequential_1_eff_392_ = dr_classifier_efficientnetb0.coder.ops.permuteOutputVar(sequential_1_eff_392__, [3 4 2 1], 4);

            sequential_1_eff_392 = dlarray(single(sequential_1_eff_392_), 'SSCB');
        end

        function [sequential_1_eff_392, sequential_1_eff_392NumDims1067] = Squeeze_To_ReshapeGraph1066(this, sequential_1_eff_397, sequential_1_eff_397NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_eff_398, sequential_1_eff_398NumDims] = dr_classifier_efficientnetb0.coder.ops.onnxSqueeze(sequential_1_eff_397, this.Vars.const_axes__1282, coder.const(sequential_1_eff_397NumDims));

            % Reshape:
            [shape1028, sequential_1_eff_392NumDims] = dr_classifier_efficientnetb0.coder.ops.prepareReshapeArgs(sequential_1_eff_398, this.Vars.new_shape__1127, coder.const(sequential_1_eff_398NumDims), 0);
            sequential_1_eff_392 = reshape(sequential_1_eff_398, shape1028{:});

            % Set graph output arguments
            sequential_1_eff_392NumDims1067 = coder.const(sequential_1_eff_392NumDims);

        end

    end

end