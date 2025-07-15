function FeatureMatrix = prepare_for_regression(InitialMatrix)
  [rowCount, colCount] = size(InitialMatrix);
  FeatureMatrix = [];
  for col = 1:colCount
    tempCol = zeros(rowCount, 1);
    tempCol2 = zeros(rowCount, 1);
    isTwoColumn = false;
    for row = 1:rowCount
      value = InitialMatrix{row, col};
      if ischar(value)
        value = lower(strtrim(value));
      endif
      switch value
        case 'yes'
          tempCol(row) = 1;
        case 'no'
          tempCol(row) = 0;
        case 'semi-furnished'
          tempCol(row) = 1;
          tempCol2(row) = 0;
          isTwoColumn = true;
        case 'unfurnished'
          tempCol(row) = 0;
          tempCol2(row) = 1;
          isTwoColumn = true;
        case 'furnished'
          tempCol(row) = 0;
          tempCol2(row) = 0;
          isTwoColumn = true;
        otherwise
          numVal = str2double(value);
          if ~isnan(numVal)
            tempCol(row) = numVal;
          else
            tempCol(row) = 0;
          endif
      endswitch
    endfor
    if isTwoColumn
      FeatureMatrix = [FeatureMatrix, tempCol, tempCol2];
    else
      FeatureMatrix = [FeatureMatrix, tempCol];
    endif
  endfor
endfunction