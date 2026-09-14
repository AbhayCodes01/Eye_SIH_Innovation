classdef ReshapeLayer1021 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_efficientnetb0.coder.ReshapeLayer1021(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_efficientnetb0.ReshapeLayer1021(cgInstance.Name);
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
        function this = ReshapeLayer1021(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'sequential_1_eff_225'};
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

        function [sequential_1_eff_225] = predict(this, sequential_1_eff_234__)
            if isdlarray(sequential_1_eff_234__)
                sequential_1_eff_234_ = stripdims(sequential_1_eff_234__);
            else
                sequential_1_eff_234_ = sequential_1_eff_234__;
            end
            sequential_1_eff_234NumDims = 4;
            sequential_1_eff_234 = dr_classifier_efficientnetb0.coder.ops.permuteInputVar(sequential_1_eff_234_, [4 3 1 2], 4);

            [sequential_1_eff_225__, sequential_1_eff_225NumDims__] = ReshapeGraph1042(this, sequential_1_eff_234, sequential_1_eff_234NumDims, false);
            sequential_1_eff_225_ = dr_classifier_efficientnetb0.coder.ops.permuteOutputVar(sequential_1_eff_225__, [3 4 2 1], 4);

            sequential_1_eff_225 = dlarray(single(sequential_1_eff_225_), 'SSCB');
        end

        function [sequential_1_eff_225, sequential_1_eff_225NumDims1043] = ReshapeGraph1042(this, sequential_1_eff_234, sequential_1_eff_234NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape1017, sequential_1_eff_225NumDims] = dr_classifier_efficientnetb0.coder.ops.prepareReshapeArgs(sequential_1_eff_234, this.Vars.new_shape__1139, coder.const(sequential_1_eff_234NumDims), 0);
            sequential_1_eff_225 = reshape(sequential_1_eff_234, shape1017{:});

            % Set graph output arguments
            sequential_1_eff_225NumDims1043 = coder.const(sequential_1_eff_225NumDims);

        end

    end

end