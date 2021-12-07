classdef Stock
    properties (Access = private)
        symbol
        dates
        returns
    end
    methods
        function obj = Stock(symbolname, datearr, closingpricearr)
            obj.symbol = symbolname; 
            obj.dates = datearr;
            for i = 2:504
                obj.returns(i-1) = 100*(closingpricearr(i) - closingpricearr(i-1))/closingpricearr(i-1);
            end
        end
        
        function returnsplot = stockplot(obj)
            x = 1:503;
            figure;
            plot(x,obj.returns);
            hold on;
            
            xlabel("Date");
            ylabel("Percent Change");
            
            xlim([-50, 550]);
            title(obj.symbol);
            x1 = obj.dates{1}.reformat;
            x2 = obj.dates{253}.reformat;
            x3 = obj.dates{503}.reformat;
            xticks([1 250 500]);
            xticklabels([x1, x2, x3]);
        end
    end
end