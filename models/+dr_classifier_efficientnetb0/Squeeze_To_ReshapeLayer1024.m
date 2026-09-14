classdef Squeeze_To_ReshapeLayer1024 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'dr_classifier_efficientnetb0.coder.Squeeze_To_ReshapeLayer1024';
        end
    end


    methods
        function this = Squeeze_To_ReshapeLayer1024(name)
            this.Name = name;
            this.OutputNames = {'sequential_1_eff_284'};
        end

        function [sequential_1_eff_284] = predict(this, sequential_1_eff_289)
            if isdlarray(sequential_1_eff_289)
                sequential_1_eff_289 = stripdims(sequential_1_eff_289);
            end
            sequential_1_eff_289NumDims = 4;
            sequential_1_eff_289 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_289, [4 3 1 2], 4);

            [sequential_1_eff_284, sequential_1_eff_284NumDims] = Squeeze_To_ReshapeGraph1048(this, sequential_1_eff_289, sequential_1_eff_289NumDims, false);
            sequential_1_eff_284 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_284, [3 4 2 1], 4);

            sequential_1_eff_284 = dlarray(single(sequential_1_eff_284), 'SSCB');
        end

        function [sequential_1_eff_284] = forward(this, sequential_1_eff_289)
            if isdlarray(sequential_1_eff_289)
                sequential_1_eff_289 = stripdims(sequential_1_eff_289);
            end
            sequential_1_eff_289NumDims = 4;
            sequential_1_eff_289 = dr_classifier_efficientnetb0.ops.permuteInputVar(sequential_1_eff_289, [4 3 1 2], 4);

            [sequential_1_eff_284, sequential_1_eff_284NumDims] = Squeeze_To_ReshapeGraph1048(this, sequential_1_eff_289, sequential_1_eff_289NumDims, true);
            sequential_1_eff_284 = dr_classifier_efficientnetb0.ops.permuteOutputVar(sequential_1_eff_284, [3 4 2 1], 4);

            sequential_1_eff_284 = dlarray(single(sequential_1_eff_284), 'SSCB');
        end

        function [sequential_1_eff_284, sequential_1_eff_284NumDims1049] = Squeeze_To_ReshapeGraph1048(this, sequential_1_eff_289, sequential_1_eff_289NumDims, Training)

            % Execute the operators:
            % Squeeze:
            [sequential_1_eff_290, sequential_1_eff_290NumDims] = dr_classifier_efficientnetb0.ops.onnxSqueeze(sequential_1_eff_289, this.Vars.const_axes__1282, sequential_1_eff_289NumDims);

            % Reshape:
            [shape, sequential_1_eff_284NumDims] = dr_classifier_efficientnetb0.ops.prepareReshapeArgs(sequential_1_eff_290, this.Vars.new_shape__1118, sequential_1_eff_290NumDims, 0);
            sequential_1_eff_284 = reshape(sequential_1_eff_290, shape{:});

            % Set graph output arguments
            sequential_1_eff_284NumDims1049 = sequential_1_eff_284NumDims;

        end

    end

end