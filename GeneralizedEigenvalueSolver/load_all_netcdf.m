function fileList = load_all_netcdf(dirName)
  dirData = dir(dirName);      %# Get the data for the current directory
  fileList = {};
  count = 0;
  for ii=1:length(dirData)
      x = (dirData(ii).name);
      if length(x) < 6
          continue
      end
      if strcmp(x(1:6), 'wrfout')
          count = count+1;
          full_file_path = [dirName, x];
          fileList{count} = full_file_path;
      end
  end
  
end
