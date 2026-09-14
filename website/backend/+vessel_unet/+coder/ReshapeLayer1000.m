classdef ReshapeLayer1000 < nnet.layer.Layer & nnet.layer.Formattable
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
            this_cg = vessel_unet.coder.ReshapeLayer1000(mlInstance);
        end
        function this_ml = matlabCodegenFromRedirected(cgInstance)
            this_ml = vessel_unet.ReshapeLayer1000(cgInstance.Name);
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
        function this = ReshapeLayer1000(mlInstance)
            this.Name = mlInstance.Name;
            this.OutputNames = {'conv2d_18'};
            if isstruct(mlInstance.Vars)
                names = fieldnames(mlInstance.Vars);
                for i=1:numel(names)
                    fieldname = names{i};
                    this.Vars.(fieldname) = vessel_unet.coder.ops.extractIfDlarray(mlInstance.Vars.(fieldname));
                end
            else
                this.Vars = [];
            end

            this.NumDims = mlInstance.NumDims;
        end

        function [conv2d_18] = predict(this, DRIVE_Vessel_U_N_106__)
            if isdlarray(DRIVE_Vessel_U_N_106__)
                DRIVE_Vessel_U_N_106_ = stripdims(DRIVE_Vessel_U_N_106__);
            else
                DRIVE_Vessel_U_N_106_ = DRIVE_Vessel_U_N_106__;
            end
            DRIVE_Vessel_U_N_106NumDims = 4;
            DRIVE_Vessel_U_N_106 = vessel_unet.coder.ops.permuteInputVar(DRIVE_Vessel_U_N_106_, [4 3 1 2], 4);

            [conv2d_18__, conv2d_18NumDims__] = ReshapeGraph1000(this, DRIVE_Vessel_U_N_106, DRIVE_Vessel_U_N_106NumDims, false);
            conv2d_18_ = vessel_unet.coder.ops.permuteOutputVar(conv2d_18__, ['as-is'], 4);

            conv2d_18 = dlarray(single(conv2d_18_), repmat('U', 1, max(2, coder.const(conv2d_18NumDims__))));
        end

        function [conv2d_18, conv2d_18NumDims1001] = ReshapeGraph1000(this, DRIVE_Vessel_U_N_106, DRIVE_Vessel_U_N_106NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape1000, conv2d_18NumDims] = vessel_unet.coder.ops.prepareReshapeArgs(DRIVE_Vessel_U_N_106, this.Vars.new_shape__392, coder.const(DRIVE_Vessel_U_N_106NumDims), 0);
            conv2d_18 = reshape(DRIVE_Vessel_U_N_106, shape1000{:});

            % Set graph output arguments
            conv2d_18NumDims1001 = coder.const(conv2d_18NumDims);

        end

    end

end