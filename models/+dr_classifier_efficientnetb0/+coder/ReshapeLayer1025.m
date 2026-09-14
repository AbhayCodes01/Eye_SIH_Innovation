classdef ReshapeLayer1025 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = dr_classifier_efficientnetb0.coder.ReshapeLayer1025(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = dr_classifier_efficientnetb0.ReshapeLayer1025(cgInstance.Name);
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
        function this = ReshapeLayer1025(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'sequential_1_eff_279'};
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

        function [sequential_1_eff_279] = predict(this, sequential_1_eff_288__)
            if isdlarray(sequential_1_eff_288__)
                sequential_1_eff_288_ = stripdims(sequential_1_eff_288__);
            else
                sequential_1_eff_288_ = sequential_1_eff_288__;
            end
            sequential_1_eff_288NumDims = 4;
            sequential_1_eff_288 = dr_classifier_efficientnetb0.coder.ops.permuteInputVar(sequential_1_eff_288_, [4 3 1 2], 4);

            [sequential_1_eff_279__, sequential_1_eff_279NumDims__] = ReshapeGraph1050(this, sequential_1_eff_288, sequential_1_eff_288NumDims, false);
            sequential_1_eff_279_ = dr_classifier_efficientnetb0.coder.ops.permuteOutputVar(sequential_1_eff_279__, [3 4 2 1], 4);

            sequential_1_eff_279 = dlarray(single(sequential_1_eff_279_), 'SSCB');
        end

        function [sequential_1_eff_279, sequential_1_eff_279NumDims1051] = ReshapeGraph1050(this, sequential_1_eff_288, sequential_1_eff_288NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape1021, sequential_1_eff_279NumDims] = dr_classifier_efficientnetb0.coder.ops.prepareReshapeArgs(sequential_1_eff_288, this.Vars.new_shape__1111, coder.const(sequential_1_eff_288NumDims), 0);
            sequential_1_eff_279 = reshape(sequential_1_eff_288, shape1021{:});

            % Set graph output arguments
            sequential_1_eff_279NumDims1051 = coder.const(sequential_1_eff_279NumDims);

        end

    end

end