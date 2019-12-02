classdef msg_id_tbl < handle
  %MAG_ID_TBL Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    active
    msg_tbl = struct;
  end
  
  methods
    function obj = mag_id_tbl(varargin)
      %MAG_ID_TBL Construct an instance of this class
      %   Detailed explanation goes here
      obj.active = true;
    end
    
    function new_ID(obj,ID_num,command)
      %METHOD1 Summary of this method goes here
      %   Detailed explanation goes here
      ID_num = strcat('ID_',ID_num);
      obj.msg_tbl.(ID_num) = command; 
    end
  end
end

