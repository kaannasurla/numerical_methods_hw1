function [Theta] = normal_equation(FeatureMatrix, Y, tol, iter)
  [sampleCount, featureCount] = size(FeatureMatrix);
  A = FeatureMatrix' * FeatureMatrix;
  rhsVector = FeatureMatrix' * Y;
  if isdefinite(A) <= 0
    Theta = zeros(featureCount + 1, 1); % θ0 este 0, restul sunt nule
    return;
  endif
  currentEstimate = zeros(featureCount, 1);
  residual = rhsVector - A * currentEstimate;
  direction = residual;
  squaredTolerance = tol^2;
  stepCounter = 0;
  while stepCounter < iter && (residual' * residual > squaredTolerance)
    matrixProduct = A * direction;
    stepSize = (residual' * residual) / (direction' * matrixProduct);
    currentEstimate = currentEstimate + stepSize * direction;
    updatedResidual = residual - stepSize * matrixProduct;
    % verificare convergenta
    if updatedResidual' * updatedResidual <= squaredTolerance
      residual = updatedResidual;
      break;
    end
    scalingFactor = (updatedResidual' * updatedResidual) / (residual' * residual);
    direction = updatedResidual + scalingFactor * direction;
    residual = updatedResidual;
    stepCounter = stepCounter + 1;
  endwhile
  % includem biasul
  Theta = [0; currentEstimate];
end
