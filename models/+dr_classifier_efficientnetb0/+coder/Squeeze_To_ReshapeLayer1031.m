classdef Squeeze_To_ReshapeLayer1031 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1031(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_efficientnetb0.Squeeze_To_ReshapeLayer1031(cgInstance.Name);
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
        function this = Squeeze_To_ReshapeLayer1031(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'sequential_1_eff_365'};
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

        function [sequential_1_eff_365] = predict(this, sequential_1_eff_370__)
            if isdlarray(sequential_1_eff_370__)
                sequential_1_eff_370_ = stripdims(sequential_1_eff_370__);
            else
                sequential_1_eff_370_ = sequential_1_eff_370__;
            end
            sequential_1_eff_370NumDims = 4;
            sequential_1_eff_370 = dr_classifier_efficientnetb0.coder.ops.permuteInputVar(sequential_1_eff_370_, [4 3 1 2], 4);

            [sequential_1_eff_365__, sequential_1_eff_365NumDims__] = Squeeze_To_ReshapeGraph1062(this, sequential_1_eff_370, sequential_1_eff_370NumDims, false);
            sequential_1_eff_365_ = dr_classifier_efficientnetb0.coder.ops.permuteOutputVar(sequential_1_eff_365__, [3 4 2 1], 4);

            sequential_1_eff_365 = dlarray(single(sequential_1_eff_365_), 'SSCB');
        end

        function [sequential_1_eff_365, sequential_1_eff_365NumDims1063] = Squeeze_To_ReshapeGraph1062(this, sequential_1_eff_370, sequential_1_eff_370NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_eff_371, sequential_1_eff_371NumDims] = dr_classifier_efficientnetb0.coder.ops.onnxSqueeze(sequential_1_eff_370, this.Vars.const_axes__1282, coder.const(sequential_1_eff_370NumDims));

            % Reshape:
            [shape1026, sequential_1_eff_365NumDims] = dr_classifier_efficientnetb0.coder.ops.prepareReshapeArgs(sequential_1_eff_371, this.Vars.new_shape__1127, coder.const(sequential_1_eff_371NumDims), 0);
            sequential_1_eff_365 = reshape(sequential_1_eff_371, shape1026{:});

            % Set graph output arguments
            sequential_1_eff_365NumDims1063 = coder.const(sequential_1_eff_365NumDims);

        end

    end

end