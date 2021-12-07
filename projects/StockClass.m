classdef Stock
    properties (Access = private)
        symbol
        dates
        returns
    end
    methods
        function obj=  Stock(symbolname, datearr, closingarr)
            obj.symbol = symbolname; 
            obj.dates = datearr;
            for i = 2:504
                obj.returns(i-1) = 100*(closingarr(i) - closingarr(i-1))/closingarr(i-1);
            end
        end
        function returnsplot = stockplot(obj)
            x = 1:503;
            figure;
            plot(x.obj.returns);
            hold on;
            xlabel("Date")
            ylabel("Percent Change");
            xlim([-50, 550]);
            title(obj.symbol);
            xtick1 = obj.dates{1}.datea;
            xtick2 = obj.dates{253}.datea;
            xtick3 = obj.dates{503}.datea;
            xticks([1 250 500]);
            xticklabels([xtick1, xtick2, xtick3])
        end
    end
end