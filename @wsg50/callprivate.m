%TEST METHOD to CALL PRIVATE METHODS
function callprivate(obj,method,varargin)
switch method
	case 'check_vars'
	case 'conf_conn'
	case 'init_b_struct'
	case 'DataReceive'
	case 'sort_buffer'
	case 'CheckStatus'
	case 'calc_payload'
		obj.calc_payload(varargin{1})
	case 'CorrectMsgLength'
		obj.CorrectMsgLength()
	case 'DataEncode'
	case 'DataSend'
	case 'decode_status'
	case 'decode_payload'
		exp = 'ID_\d{2}';
		match = regexp(varargin{1},exp,'match');
		obj.decode_payload(match{1})
	otherwise
		error('not a valid method')
		
end
end