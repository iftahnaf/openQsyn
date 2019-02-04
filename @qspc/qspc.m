classdef qspc
%QSPC is class is used to generate and store specificstions
%
%Usage
% 
%   spc = QSPC(name,w,upper,lower)   constracts a qspc object called spc 
%   with desired name, frequency vector, corresponding  upper and lower bounds
%   
%   For help on QSPC constracion see help QSPC/qspc    
%
%Alternatively a QSPC can be generated using on of the following 
%   
%   spc = qspc.rsrs(...)    reference step response specification (servo)
%   spc = qspc.idsrs(...)   input disturbance step response specification
%   spc = qspc.odsrs(...)   output disturbance step response specification
%   
%   See help qspc/<method> for usage of the above methods
%
%For a list QSPC methods type: methods qspc
%   
%See also: qspc.rsrs qspc.idsrs qspc.odsrs


    properties
        name
        frequency
        upper
        lower 
        timespc
        timeres
    end
    
    methods
        function obj = qspc(name,w,upper,lower,timespc,timeres)
            %QSPC Construct an instance of this class
            %Usage
            %
            %   spc = QSPC(name,w,upper,lower)   constracts a qspc object called spc
            %   with desired name, frequency vector, corresponding  upper and lower bounds
            %
            %Inputs
            %
            %   name    string definning the spec name. the name must correspond to a
            %           specification function. predetemied names are 'odsrs', 'rsrs',
            %           'idsrs'
            %   w       frequnecy vector
            %   upper   upper bound in dB. must be a vector of same lenght as w or a
            %           scalar if a constant upper bound is desired
            %   lower   lower bound in dB.
            %Example
            %
            %   spec1 = QSPC('odsrs',logspace(-2,2),6)   creates a qpsc object spec1
            %   with name 'odsrs' and with an upper bound of 6dB for frequencies
            %   between 10^-2 and 10^2.
            %
            if nargin<5, timespc=[]; timeres=[]; end
            if nargin<4, lower=[]; end
            
            % check inputs
            if ~ischar(name), error('qpar name must be a charecter array'); end
            if ~isnumeric(w), error('frqueincy must be a numeric scalar'); end
            if ~isnumeric(upper), error('upper bound must be a numeric scalar'); end
            if ~isnumeric(lower), error('lower bound must be a numeric scalar'); end
            if any(w<0) || min(size(w)>2)
                error('w must be a vector of positive values');
            end
            
            if isscalar(upper)
                upper = upper*ones(1,length(w));
            elseif  length(upper)~=length(w)
                error('upper spec must be scalar or a vector of same length as w');
            end
            
            if ~isempty(lower)
                if isscalar(lower)
                    lower = lower*ones(1,length(w));
                elseif length(lower)~=length(w)
                    error('lower spec must be scalar or a vector of same length as w');
                end
            end
            
            obj.name = name;
            obj.frequency = w;
            obj.upper = upper;
            obj.lower = lower;
            obj.timespc = timespc;
            obj.timeres = timeres;
        end      
    end
    
    methods (Static)
        obj = rsrs( Tr,M,Ts,Td,w,wco,ordr,Ks,tf,plt,dt,n )
        obj = idsrs( Ts,Max,M,td,w,tf,zmin,plt,dt,n )
        obj = odsrs( Tr,M,Ts,Td,w,ordr,Ks,tf,plt,dt,n )
        [spec_w,spec_t,tab] = spc_rs2(spc_tab,w,dt,plt,n)
        [spec_w,spec_t,tab] = spc_rs3(spc_tab,w,dt,plt,n)
        [spec_w,spec_t,tab] = spc_rs31(spc_tab,w,dt,plt,n)
        [spec_w,spec_t,tab] = spc_id2(spc_tab,w,dt,plt,zmin,n)
        [spec_w,spec_t,tab] = spc_od2(spc_tab,w,dt,plt,n)
        [spec_w,spec_t,tab] = spc_od3(spc_tab,w,dt,plt,n)
        [spec_w,spec_t,tab] = spc_od31(spc_tab,w,dt,plt,n)
    end
    
    
end

