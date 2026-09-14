classdef ReshapeLayer1000 < nnet.layer.Layer & nnet.layer.Formattable
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
            name = 'vessel_unet.coder.ReshapeLayer1000';
        end
    end


    methods
        function this = ReshapeLayer1000(name)
            this.Name = name;
            this.OutputNames = {'conv2d_18'};
        end

        function [conv2d_18] = predict(this, DRIVE_Vessel_U_N_106)
            if isdlarray(DRIVE_Vessel_U_N_106)
                DRIVE_Vessel_U_N_106 = stripdims(DRIVE_Vessel_U_N_106);
            end
            DRIVE_Vessel_U_N_106NumDims = 4;
            DRIVE_Vessel_U_N_106 = vessel_unet.ops.permuteInputVar(DRIVE_Vessel_U_N_106, [4 3 1 2], 4);

            [conv2d_18, conv2d_18NumDims] = ReshapeGraph1000(this, DRIVE_Vessel_U_N_106, DRIVE_Vessel_U_N_106NumDims, false);
            conv2d_18 = vessel_unet.ops.permuteOutputVar(conv2d_18, ['as-is'], 4);

            conv2d_18 = dlarray(single(conv2d_18), repmat('U', 1, max(2, conv2d_18NumDims)));
        end

        function [conv2d_18] = forward(this, DRIVE_Vessel_U_N_106)
            if isdlarray(DRIVE_Vessel_U_N_106)
                DRIVE_Vessel_U_N_106 = stripdims(DRIVE_Vessel_U_N_106);
            end
            DRIVE_Vessel_U_N_106NumDims = 4;
            DRIVE_Vessel_U_N_106 = vessel_unet.ops.permuteInputVar(DRIVE_Vessel_U_N_106, [4 3 1 2], 4);

            [conv2d_18, conv2d_18NumDims] = ReshapeGraph1000(this, DRIVE_Vessel_U_N_106, DRIVE_Vessel_U_N_106NumDims, true);
            conv2d_18 = vessel_unet.ops.permuteOutputVar(conv2d_18, ['as-is'], 4);

            conv2d_18 = dlarray(single(conv2d_18), repmat('U', 1, max(2, conv2d_18NumDims)));
        end

        function [conv2d_18, conv2d_18NumDims1001] = ReshapeGraph1000(this, DRIVE_Vessel_U_N_106, DRIVE_Vessel_U_N_106NumDims, Training)

            % Execute the operators:
            % Reshape:
            [shape, conv2d_18NumDims] = vessel_unet.ops.prepareReshapeArgs(DRIVE_Vessel_U_N_106, this.Vars.new_shape__392, DRIVE_Vessel_U_N_106NumDims, 0);
            conv2d_18 = reshape(DRIVE_Vessel_U_N_106, shape{:});

            % Set graph output arguments
            conv2d_18NumDims1001 = conv2d_18NumDims;

        end

    end

end