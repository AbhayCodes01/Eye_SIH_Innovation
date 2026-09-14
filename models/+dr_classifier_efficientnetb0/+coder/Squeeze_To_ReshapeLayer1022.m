classdef Squeeze_To_ReshapeLayer1022 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1022(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_efficientnetb0.Squeeze_To_ReshapeLayer1022(cgInstance.Name);
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
        function this = Squeeze_To_ReshapeLayer1022(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'sequential_1_eff_257'};
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

        function [sequential_1_eff_257] = predict(this, sequential_1_eff_262__)
            if isdlarray(sequential_1_eff_262__)
                sequential_1_eff_262_ = stripdims(sequential_1_eff_262__);
            else
                sequential_1_eff_262_ = sequential_1_eff_262__;
            end
            sequential_1_eff_262NumDims = 4;
            sequential_1_eff_262 = dr_classifier_efficientnetb0.coder.ops.permuteInputVar(sequential_1_eff_262_, [4 3 1 2], 4);

            [sequential_1_eff_257__, sequential_1_eff_257NumDims__] = Squeeze_To_ReshapeGraph1044(this, sequential_1_eff_262, sequential_1_eff_262NumDims, false);
            sequential_1_eff_257_ = dr_classifier_efficientnetb0.coder.ops.permuteOutputVar(sequential_1_eff_257__, [3 4 2 1], 4);

            sequential_1_eff_257 = dlarray(single(sequential_1_eff_257_), 'SSCB');
        end

        function [sequential_1_eff_257, sequential_1_eff_257NumDims1045] = Squeeze_To_ReshapeGraph1044(this, sequential_1_eff_262, sequential_1_eff_262NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_eff_263, sequential_1_eff_263NumDims] = dr_classifier_efficientnetb0.coder.ops.onnxSqueeze(sequential_1_eff_262, this.Vars.const_axes__1282, coder.const(sequential_1_eff_262NumDims));

            % Reshape:
            [shape1018, sequential_1_eff_257NumDims] = dr_classifier_efficientnetb0.coder.ops.prepareReshapeArgs(sequential_1_eff_263, this.Vars.new_shape__1118, coder.const(sequential_1_eff_263NumDims), 0);
            sequential_1_eff_257 = reshape(sequential_1_eff_263, shape1018{:});

            % Set graph output arguments
            sequential_1_eff_257NumDims1045 = coder.const(sequential_1_eff_257NumDims);

        end

    end

end