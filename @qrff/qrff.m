classdef qrff
    %QRFF Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        type
        par1
        par2
    end
    
    methods
        function obj = qrff(type,par1,varargin)
            %QRFF Construct an instance of the qrff class
            %   
            %   Usage: 
            %
            %   rff = QRFF(type,par)   defines a qrff object of specified "type" 
            %   using the qpar or numerical parameter "par". 
            %
            %   rff = qrff(type,par1,par2)    is used is type requires two
            %   parameters 
            %
            %   Avilables input combinations
            %       qrff('gain',k)      uncertain gain k
            %       qrff('unc',w,M)     unstructured uncertainty M(w)
            %       qrff('delay',tau)   time delay exp(-tau*s) 
            %       qrff('dc',a)        first order dc element (s/a+1)
            %       qrff('dc',w,z)      second order dc element (s^2/w^2+2*z*s/w+1)
            %       qrff('hf',a)        first order hf element (a+s)
            %       qrff('hf',w,z)      second order hf element (s^2+2*z*w*s+w^2)
            %     
            %   Example 1: 2nd order dc element with uncertain wn and zeta
            %       wn = qpar('wn',4,4,8);
            %       zeta = qpar('z',0.4,0.4,0.6);
            %       rffElement = QRFF('dc',wn,zeta);
            % 
            %   Example 2: 2nd order hf element with uncertain wn and constant zeta 
            %       wn = qpar('wn',4,4,8);
            %       zeta = 0.4;
            %       rffElement = QRFF('hc'wn'zeta)
            %
            %   Example 3: unstructured uncertainty
            %       wunc = [0.1 0.5 1 5 10 20 50];
            %       M = [1 2 5 5 5 10 20];
            %       rffElement = qrff('unc',wunc,M);
            %
            
            validStrings = {'gain','delay','dc','hf','uns','int','poly'};
            validatestring(type,validStrings,'qrff','type',1);
            p = inputParser;
            if strcmp(type,'poly')
                p.addRequired('par1',@(x)  isnumeric(x) && isrow(x));
            else
                p.addRequired('par1',@(x) isscalar(x) && (isnumeric(x) || isa(x,'qpar')));
            end
            p.addOptional('par2',[],@(x) isscalar(x) && (isnumeric(x) || isa(x,'qpar')));
            p.parse(par1,varargin{:});
            
            obj.type = type;
            obj.par1 = p.Results.par1;
            obj.par2 = p.Results.par2;
            
        end
        
        function h = qrff2func(obj)
            %QRFF2FUNC return an handle to a function object f@(p1,p2,...pn,s)
            %with p1,...,pn corresponding to uncertain parameters.
                        
            Pars = {};
            for k = 1:length(obj)
                if isa(obj(k).par1,'qpar')
                    par1s = obj(k).par1.name;
                    Pars = {Pars{:},par1s};
                else
                    par1s = sprintf('%g',obj(k).par1);
                end
                if isa(obj(k).par2,'qpar')
                    par2s = obj(k).par2.name;
                    Pars = {Pars{:},par2s};
                else
                    par2s = sprintf('%g',obj(k).par2);
                end
                switch obj(k).type
                    case 'gain'
                        Sk = par1s;
                    case 'delay'
                        Sk = sprintf('exp(-s.*%s)',par1s);
                    case 'dc'
                        if isempty(obj(k).par2)
                            Sk = sprintf('(1+s./%s)',par1s);
                        else
                            SdW = sprintf('s./%s',par1s);
                            Sk = sprintf('(1 + 2*%s.*(%s) + (%s).^2)',par2s,SdW,SdW);
                        end
                    case 'hf'
                        if isempty(obj(k).par2)
                            Sk = sprintf('(s+%s)',par1s);
                        else
                            wn = par1s;
                            zeta = par2s;
                            Sk = sprintf('(s.^2 + 2*%s.*%s + %s.^2)',zeta,wn,wn);
                        end
                    case 'poly'
                        s = '';
                        n = length(obj(k).par1)-1;
                        for jj = 1:n+1
                            if obj(k).par1(jj)~=0
                                s = strcat(s,sprintf(' %g*s.^%i + ',obj(k).par1(jj),n+1-jj));
                            end
                        end
                        Sk = ['(',s(2:end-2),')'];
                end
                
                if k==1
                    S = Sk;
                else
                    S = [S,'.*',Sk];
                end
            end
            if ~isempty(Pars)
                args = sprintf('%s, ',Pars{:});
                argF = sprintf('@(%s, s) ',args(1:end-2));
            else
                argF = '@(s) ';
            end
            h = str2func([argF S]);
            
        end
        function p = pars(obj)
            %PARS
            p = qpar();
            k = 1;
            for jj = 1:length(obj)
                if isa(obj(jj).par1,'qpar'), p(k,1) = obj(jj).par1; k=k+1; end
                if isa(obj(jj).par2,'qpar'), p(k,1) = obj(jj).par2; k=k+1; end
            end
        end
    end
    
    %methods(Hidden=true)
    methods
        T = rffel(obj,w,dist)
        T = rffpz(obj,w,pzf,dist)
        T = rffcpz(obj,w,pzf,dist)
    end
    
    methods(Static)
        T = rffmul(t1,t2,dist)
        T = rffutil1(w,phi,zmin,zmax,wmin,wmax,form,pzf,kase)
        Tnew = rffutil3(Tleft,T,Tright,edge,dist)
        Tnew = cltmp(t,dist)
    end
end

