function [Y, numDimsY] = onnxSoftmax13(X_, ONNXaxis_, numDimsX_)
% Implements the ONNX Softmax function:
% Softmax(input, axis) = Exp(input) / ReduceSum(Exp(input), axis=axis, keepdims=1)
% The input is constrained to floating point types.
%#codegen

% Copyright 2024 The MathWorks, Inc.

ONNXaxis   = dr_classifier_efficientnetb0.coder.ops.extractIfDlarray(ONNXaxis_);
numDimsX   = dr_classifier_efficientnetb0.coder.ops.extractIfDlarray(numDimsX_);

if ONNXaxis < 0
    ONNXaxis = ONNXaxis + numDimsX;
end
DLTaxis = coder.const(numDimsX - ONNXaxis);

X = X_ - max(X_, [], DLTaxis); % Subtract max(X) for numerical stability
expX = exp(X);
dims = coder.const(dr_classifier_efficientnetb0.coder.ops.prepareReduceArgs(ONNXaxis, numDimsX));
Y = expX ./ sum(expX, dims);
numDimsY = numDimsX;

end