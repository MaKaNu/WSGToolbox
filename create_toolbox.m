%% Creates toolbox based on prj file
proj_file = './build/WSGtoolbox.prj';

version = '1.0.0';

xproj = xmlread(fullfile(proj_file));

% Get the Version node from prj file and change the value in the DOMnode
% object.
paramVersions=xproj.getElementsByTagName('param.version');
paramVersion = paramVersions.item(0);
versionNode = getNodeValue(paramVersion.item(0));
disp(strcat('Value of Version Node:', string(versionNode)))
setNodeValue(paramVersion.item(0),version); 
versionNode = getNodeValue(paramVersion.item(0));
disp(strcat('Changed Value of Version Node:', string(versionNode)))

xmlwrite(proj_file, xproj)

matlab.addons.toolbox.packageToolbox('./build/WSGtoolbox.prj')
